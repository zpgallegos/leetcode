# https://leetcode.com/problems/the-airport-with-the-most-traffic/


import pandas as pd


def airport_with_most_traffic(flights: pd.DataFrame) -> pd.DataFrame:
    cnts = (
        pd.concat(
            (
                flights.rename(columns={"departure_airport": "airport_id"}),
                flights.rename(columns={"arrival_airport": "airport_id"}),
            ),
            axis=0,
        )
        .groupby("airport_id")
        .flights_count.sum()
    )

    return pd.DataFrame(cnts[cnts == cnts.max()].index)
