# https://leetcode.com/problems/bikes-last-time-used/

import pandas as pd


def last_used_time(bikes: pd.DataFrame) -> pd.DataFrame:
    return (
        bikes.groupby("bike_number")
        .end_time.max()
        .sort_values(ascending=False)
        .reset_index()
    )
