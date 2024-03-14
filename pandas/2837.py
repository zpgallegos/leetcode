# https://leetcode.com/problems/total-traveled-distance/

import pandas as pd


def get_total_distance(users: pd.DataFrame, rides: pd.DataFrame) -> pd.DataFrame:
    return (
        users.merge(rides, how="left", on="user_id")
        .fillna(0)
        .groupby(["user_id", "name"])
        .distance.sum()
        .reset_index()
        .rename(columns={"distance": "traveled distance"})
        .sort_values("user_id")
    )
