# https://leetcode.com/problems/second-day-verification/


import pandas as pd


def find_second_day_signups(emails: pd.DataFrame, texts: pd.DataFrame) -> pd.DataFrame:
    emails["day_after_signup"] = emails.signup_date.dt.date + pd.Timedelta(days=1)
    texts["action_date"] = texts.action_date.dt.date

    return (
        emails.merge(
            texts.query("signup_action == 'Verified'"),
            left_on=["email_id", "day_after_signup"],
            right_on=["email_id", "action_date"],
            how="inner",
        )
        .query("day_after_signup == action_date")[["user_id"]]
        .sort_values("user_id")
    )
