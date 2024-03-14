# https://leetcode.com/problems/find-expensive-cities/

import pandas as pd


def find_expensive_cities(listings: pd.DataFrame) -> pd.DataFrame:
    grpd = listings.groupby("city").price.mean().reset_index()
    return grpd.loc[grpd.price > listings.price.mean(), ["city"]].sort_values("city")
