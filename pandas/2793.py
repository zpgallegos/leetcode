# https://leetcode.com/problems/status-of-flight-tickets/description/


import pandas as pd


def ticket_status(flights: pd.DataFrame, passengers: pd.DataFrame) -> pd.DataFrame:
    d = passengers.merge(flights, on="flight_id").sort_values(
        ["flight_id", "booking_time"]
    )
    d["rn"] = d.groupby("flight_id").cumcount() + 1
    d["Status"] = d.apply(
        lambda row: "Confirmed" if row.rn <= row.capacity else "Waitlist", axis=1
    )
    return d[["passenger_id", "Status"]].sort_values("passenger_id")
