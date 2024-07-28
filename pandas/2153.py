# https://leetcode.com/problems/the-number-of-passengers-in-each-bus-ii/solutions/

import pandas as pd


def number_of_passengers(buses: pd.DataFrame, passengers: pd.DataFrame) -> pd.DataFrame:
    buses = buses.set_index("bus_id")
    passengers["waiting"] = True
    passengers = passengers.set_index("passenger_id")

    out = {}
    for bus in buses.itertuples():
        out[bus.Index] = 0
        capacity = bus.capacity

        waiting = passengers[
            (passengers.waiting) & (passengers.arrival_time <= bus.arrival_time)
        ]
        for p in waiting.itertuples():
            out[bus.Index] += 1
            passengers.loc[p.Index, "waiting"] = False
            capacity -= 1
            if not capacity:
                break

    return pd.DataFrame(out.items(), columns=["bus_id", "passengers_cnt"]).sort_values(
        "bus_id"
    )
