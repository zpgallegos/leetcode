# https://leetcode.com/problems/find-top-performing-driver/

import pandas as pd


def get_top_performing_drivers(
    drivers: pd.DataFrame, vehicles: pd.DataFrame, trips: pd.DataFrame
) -> pd.DataFrame:
    d = (
        drivers.merge(vehicles, on="driver_id")
        .merge(trips, on="vehicle_id")
        .groupby(["driver_id", "accidents", "fuel_type"])
        .agg(
            rating=("rating", lambda x: x.mean().round(2)), distance=("distance", "sum")
        )
        .sort_values(
            ["fuel_type", "rating", "distance"], ascending=[True, False, False]
        )
    )
    d["idx"] = d.groupby("fuel_type").cumcount()

    return d.query("idx == 0").reset_index()[
        ["fuel_type", "driver_id", "rating", "distance"]
    ]
