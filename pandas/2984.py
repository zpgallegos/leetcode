# https://leetcode.com/problems/find-peak-calling-hours-for-each-city/

import pandas as pd


def peak_calling_hours(calls: pd.DataFrame) -> pd.DataFrame:
    calls["hour"] = calls.call_time.dt.hour
    grpd = (
        calls.groupby(["city", "hour"])
        .size()
        .reset_index()
        .rename(columns={0: "total_calls"})
    )

    return (
        grpd[grpd.groupby("city").total_calls.transform(lambda x: x == x.max())]
        .sort_values(["hour", "city"], ascending=[False, False])
        .rename(columns={"hour": "peak_calling_hour", "total_calls": "number_of_calls"})
    )
