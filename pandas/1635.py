# https://leetcode.com/problems/hopper-company-queries-i/description/

import pandas as pd


def hopper_company(
    drivers: pd.DataFrame, rides: pd.DataFrame, accepted_rides: pd.DataFrame
) -> pd.DataFrame:
    begin = "2020-01-01"
    end = "2020-12-31"
    all_months = range(1, 13)

    drivers["month"] = drivers.join_date.dt.month
    rides["month"] = rides.requested_at.dt.month

    drivers = drivers.sort_values("join_date")
    drivers["i"] = [i + 1 for i in range(len(drivers))]

    driver_counts = (
        drivers.query(f"join_date >= '{begin}' and join_date <= '{end}'")
        .groupby("month")
        .agg(driver_count=("i", "max"))
        .reindex(all_months, fill_value=0)
        .sort_index()
        .reset_index()
    )
    driver_counts["active_drivers"] = driver_counts.driver_count.cummax()

    acc = (
        rides.query(f"requested_at >= '{begin}' and requested_at <= '{end}'")
        .merge(accepted_rides, on="ride_id")
        .groupby("month")
        .size()
        .reindex(all_months, fill_value=0)
        .rename("accepted_rides")
        .reset_index()
    )

    return driver_counts[["month", "active_drivers"]].merge(acc, on="month")
