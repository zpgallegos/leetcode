# https://leetcode.com/problems/find-active-users/description/

import pandas as pd


def find_active_users(users: pd.DataFrame) -> pd.DataFrame:
    users = users.sort_values(["user_id", "created_at"])
    users["dif"] = users.groupby("user_id").created_at.diff(1).dt.days

    return users.loc[users.dif <= 7, ["user_id"]].drop_duplicates()
