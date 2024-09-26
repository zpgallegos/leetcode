# https://leetcode.com/problems/number-of-times-a-driver-was-a-passenger/description/


import pandas as pd


def driver_passenger(rides: pd.DataFrame) -> pd.DataFrame:
    return (
        rides.passenger_id.value_counts()
        .rename("cnt")
        .reindex(rides.driver_id.unique())
        .fillna(0)
        .reset_index()
        .rename(columns={"passenger_id": "driver_id"})
    )
