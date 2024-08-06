# https://leetcode.com/problems/flight-occupancy-and-waitlist-analysis/description/

import pandas as pd


def waitlist_analysis(flights: pd.DataFrame, passengers: pd.DataFrame) -> pd.DataFrame:
    d = flights.merge(passengers, on="flight_id", how="left")
    cnts = (
        d.groupby(["flight_id", "capacity"])
        .passenger_id.nunique()
        .rename("ps")
        .reset_index()
    )

    cnts["booked_cnt"] = cnts.apply(lambda row: min(row.ps, row.capacity), axis=1)
    cnts["waitlist_cnt"] = cnts.ps - cnts.booked_cnt

    return cnts[["flight_id", "booked_cnt", "waitlist_cnt"]].sort_values("flight_id")
