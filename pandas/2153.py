# https://leetcode.com/problems/the-number-of-passengers-in-each-bus-ii/description/

import pandas as pd


def number_of_passengers(buses: pd.DataFrame, passengers: pd.DataFrame) -> pd.DataFrame:
    passengers["waiting"] = True
    passengers = passengers.sort_values("arrival_time")

    out = []
    for bus in buses.sort_values("arrival_time").itertuples():
        waiting = passengers[
            (passengers.waiting) & (passengers.arrival_time <= bus.arrival_time)
        ]
        
        taken = 0
        for passenger in waiting.itertuples():
            if taken == bus.capacity:
                break

            passengers.loc[passenger.Index, "waiting"] = False
            taken += 1
        
        out.append({"bus_id": bus.bus_id, "passengers_cnt": taken})
    
    return pd.DataFrame(out).sort_values("bus_id")