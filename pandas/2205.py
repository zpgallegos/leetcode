# https://leetcode.com/problems/the-number-of-users-that-are-eligible-for-discount/description/

import pandas as pd
from datetime import datetime


def count_valid_users(
    purchases: pd.DataFrame, start_date: datetime, end_date: datetime, min_amount: int
) -> pd.DataFrame:
    return pd.DataFrame(
        {
            "user_cnt": [
                purchases.loc[
                    (purchases.amount >= min_amount)
                    & (purchases.time_stamp >= start_date)
                    & (purchases.time_stamp <= end_date)
                ].user_id.nunique()
            ]
        }
    )
