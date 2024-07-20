# https://leetcode.com/problems/find-cities-in-each-state/

import pandas as pd


def find_cities(cities: pd.DataFrame) -> pd.DataFrame:
    return (
        cities.groupby("state")
        .apply(lambda x: ", ".join(sorted(x.city)))
        .reset_index()
        .rename(columns={0: "cities"})
    )
