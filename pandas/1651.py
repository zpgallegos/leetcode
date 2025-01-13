# https://leetcode.com/problems/hopper-company-queries-iii/

import pandas as pd


def hopper_company_queries(
    drivers: pd.DataFrame, rides: pd.DataFrame, accepted_rides: pd.DataFrame
) -> pd.DataFrame:
    begin = "2020-01-01"
    end = "2020-12-31"

    rides["month"] = rides.requested_at.dt.month

    agg = (
        rides[(rides.requested_at >= begin) & (rides.requested_at <= end)]
        .merge(accepted_rides, on="ride_id")
        .groupby("month")
        .agg(
            average_ride_distance=("ride_distance", "sum"),
            average_ride_duration=("ride_duration", "sum"),
        )
        .reindex(range(1, 13), fill_value=0)
        .sort_index()
        .rolling(3, min_periods=3)
        .mean()
        .round(2)
        .query("month >= 3")
    )

    agg.index -= 2

    return agg.reset_index()
