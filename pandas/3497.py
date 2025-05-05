# https://leetcode.com/problems/analyze-subscription-conversion/

import pandas as pd


def analyze_subscription_conversion(user_activity: pd.DataFrame) -> pd.DataFrame:
    user_activity["last"] = user_activity.groupby("user_id").activity_type.shift(1)
    incl = user_activity.query(
        "activity_type == 'paid' and last == 'free_trial'"
    ).user_id.unique()

    return (
        user_activity[user_activity.user_id.isin(incl)]
        .groupby(["user_id", "activity_type"])
        .activity_duration.mean()
        .add(1e-6)
        .round(2)
        .loc[:, ["free_trial", "paid"]]
        .reset_index()
        .pivot_table(index="user_id", columns="activity_type")
        .droplevel(0, axis=1)
        .reset_index()
        .rename(
            columns={"free_trial": "trial_avg_duration", "paid": "paid_avg_duration"}
        )
        .sort_values("user_id")
    )
