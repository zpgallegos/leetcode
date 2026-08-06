# https://leetcode.com/problems/the-number-of-passengers-in-each-bus-ii/description/

import numpy as np
import pandas as pd

buses_data = [[1, 2, 1], [2, 4, 10], [3, 7, 2]]
buses = pd.DataFrame(buses_data, columns=["bus_id", "arrival_time", "capacity"]).astype(
    {"bus_id": "Int64", "arrival_time": "Int64", "capacity": "Int64"}
)

passengers_data = [[11, 1], [12, 1], [13, 5], [14, 6], [15, 7]]
passengers = pd.DataFrame(
    passengers_data, columns=["passenger_id", "arrival_time"]
).astype({"passenger_id": "Int64", "arrival_time": "Int64"})


def number_of_passengers(buses: pd.DataFrame, passengers: pd.DataFrame) -> pd.DataFrame:

    out = []
    waiting = 0
    last_arrival_time = 0

    for row in buses.sort_values("arrival_time").itertuples():

        waiting += (
            (passengers.arrival_time > last_arrival_time)
            & (passengers.arrival_time <= row.arrival_time)
        ).sum()

        picked_up = min(int(row.capacity), waiting)
        waiting -= picked_up
        last_arrival_time = row.arrival_time

        out.append({"bus_id": row.bus_id, "passengers_cnt": picked_up})

    return pd.DataFrame(out).sort_values("bus_id")
