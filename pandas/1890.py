# https://leetcode.com/problems/the-latest-login-in-2020/

import pandas as pd


def latest_login(logins: pd.DataFrame) -> pd.DataFrame:
    return (
        logins[logins.time_stamp.dt.year == 2020]
        .groupby("user_id")
        .time_stamp.max()
        .rename("last_stamp")
        .reset_index()
    )
