# https://leetcode.com/problems/users-that-actively-request-confirmation-messages/description/


import pandas as pd


def find_requesting_users(
    signups: pd.DataFrame, confirmations: pd.DataFrame
) -> pd.DataFrame:
    confirmations = confirmations.sort_values(["user_id", "time_stamp"])
    confirmations["dif"] = confirmations.groupby("user_id").time_stamp.diff(
        1
    ).dt.total_seconds() / (60 * 60)

    return confirmations.query("dif <= 24")[["user_id"]].drop_duplicates()
