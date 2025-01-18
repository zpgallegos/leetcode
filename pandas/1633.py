# https://leetcode.com/problems/percentage-of-users-attended-a-contest/

import pandas as pd


def users_percentage(users: pd.DataFrame, register: pd.DataFrame) -> pd.DataFrame:
    return (
        (
            (register.contest_id.value_counts().rename("percentage") / users.shape[0])
            * 100
        )
        .round(2)
        .reset_index()
        .rename(columns={"index": "contest_id"})
        .sort_values(["percentage", "contest_id"], ascending=[False, True])
    )
