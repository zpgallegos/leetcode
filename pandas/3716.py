# https://leetcode.com/problems/find-churn-risk-customers/description/

import pandas as pd


def find_churn_risk_customers(subscription_events: pd.DataFrame) -> pd.DataFrame:

    subscription_events = subscription_events.assign(
        event_date=pd.to_datetime(subscription_events.event_date)
    )

    last = (
        subscription_events.loc[
            subscription_events.groupby("user_id")["event_id"].idxmax()
        ]
        .query("event_type != 'cancel'")
        .rename(
            columns={
                "plan_name": "current_plan",
                "monthly_amount": "current_monthly_amount",
            }
        )
    )

    agg = (
        subscription_events.groupby("user_id")
        .agg(
            max_historical_amount=("monthly_amount", "max"),
            min_event_date=("event_date", "min"),
            max_event_date=("event_date", "max"),
            has_downgrade=("event_type", lambda s: s.eq("downgrade").any()),
        )
        .query("has_downgrade")
        .assign(
            days_as_subscriber=lambda df: (
                df["max_event_date"] - df["min_event_date"]
            ).dt.days
        )
        .query("days_as_subscriber >= 60")
    )

    return (
        last.merge(agg, on="user_id")
        .assign(
            current_prop=lambda df: df.current_monthly_amount.div(
                df.max_historical_amount
            )
        )
        .query("current_prop < .5")
        .sort_values(["days_as_subscriber", "user_id"], ascending=[False, True])[
            [
                "user_id",
                "current_plan",
                "current_monthly_amount",
                "max_historical_amount",
                "days_as_subscriber",
            ]
        ]
    )
