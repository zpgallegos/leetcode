# https://leetcode.com/problems/the-airport-with-the-most-traffic/description/

import pandas as pd


def airport_with_most_traffic(flights: pd.DataFrame) -> pd.DataFrame:
    d = (
        pd.concat(
            (
                flights[["departure_airport", "flights_count"]].rename(
                    columns={"departure_airport": "airport_id"}
                ),
                flights[["arrival_airport", "flights_count"]].rename(
                    columns={"arrival_airport": "airport_id"}
                ),
            ),
            axis=0,
        )
        .groupby("airport_id")
        .flights_count.sum()
    )

    return pd.DataFrame(d.loc[d == d.max()].index)
