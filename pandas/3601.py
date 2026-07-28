# https://leetcode.com/problems/find-drivers-with-improved-fuel-efficiency/

import pandas as pd


def find_improved_efficiency_drivers(
    drivers: pd.DataFrame, trips: pd.DataFrame
) -> pd.DataFrame:

    trips = trips.assign(
        trip_date=pd.to_datetime(trips.trip_date),
        eff=trips.distance_km / trips.fuel_consumed,
    )

    trips = trips.assign(
        half=trips.trip_date.dt.month.gt(6).map(
            {False: "first_half_avg", True: "second_half_avg"}
        ),
    )

    avgs = (
        trips.groupby(["driver_id", "half"])
        .eff.mean()
        .unstack()
        .rename_axis(columns=None)
    )

    return (
        avgs.query("second_half_avg > first_half_avg")
        .assign(
            efficiency_improvement=lambda df: df.second_half_avg - df.first_half_avg
        )
        .join(drivers.set_index("driver_id").driver_name)
        .round(2)
        .sort_values(["efficiency_improvement", "driver_name"], ascending=[False, True])
        .reset_index()[
            [
                "driver_id",
                "driver_name",
                "first_half_avg",
                "second_half_avg",
                "efficiency_improvement",
            ]
        ]
    )
