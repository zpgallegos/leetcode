# https://leetcode.com/problems/bikes-last-time-used/description/

import pandas as pd


def last_used_time(bikes: pd.DataFrame) -> pd.DataFrame:
    return (
        bikes.groupby("bike_number")
        .end_time.max()
        .reset_index()
        .rename(columns={0: "end_time"})
        .sort_values("end_time", ascending=False)
    )
