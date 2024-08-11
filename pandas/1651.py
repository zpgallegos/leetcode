# https://leetcode.com/problems/hopper-company-queries-iii/description/


import pandas as pd


def hopper_company_queries(
    drivers: pd.DataFrame, rides: pd.DataFrame, accepted_rides: pd.DataFrame
) -> pd.DataFrame:
    start, end = "2020-01-01", "2020-12-31"

    d = rides.query(f"requested_at >= '{start}' and requested_at <= '{end}'").merge(
        accepted_rides, on="ride_id"
    )
    d["month"] = d.requested_at.dt.month

    agg = (
        d.groupby("month")
        .agg(dist=("ride_distance", "sum"), dur=("ride_duration", "sum"))
        .reindex(range(1, 13), fill_value=0)
    )

    roll = agg.rolling(3)
    agg["average_ride_distance"] = roll.dist.mean()
    agg["average_ride_duration"] = roll.dur.mean()

    agg.index = agg.index - 2

    return agg[["average_ride_distance", "average_ride_duration"]].dropna().round(2).reset_index()
