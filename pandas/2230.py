# https://leetcode.com/problems/the-users-that-are-eligible-for-discount/

import pandas as pd
from datetime import datetime


def find_valid_users(
    purchases: pd.DataFrame, start_date: datetime, end_date: datetime, min_amount: int
) -> pd.DataFrame:
    return (
        purchases.loc[
            (purchases.amount >= min_amount)
            & (purchases.time_stamp >= start_date)
            & (purchases.time_stamp <= end_date),
            ["user_id"],
        ]
        .drop_duplicates()
        .sort_values("user_id")
    )
