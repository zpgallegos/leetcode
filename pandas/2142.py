# https://leetcode.com/problems/the-number-of-passengers-in-each-bus-i/

import pandas as pd


def count_passengers_in_bus(
    buses: pd.DataFrame, passengers: pd.DataFrame
) -> pd.DataFrame:
    buses = buses.set_index("bus_id").arrival_time.sort_values().to_dict()

    def assign_bus(parrival: int):
        for bus_id, barrival in buses.items():
            if parrival <= barrival:
                return bus_id
        return None

    passengers["bus_id"] = passengers.arrival_time.apply(assign_bus)

    return (
        passengers.bus_id.value_counts()
        .rename("passengers_cnt")
        .reindex(buses.keys(), fill_value=0)
        .sort_index()
        .reset_index()
    )
