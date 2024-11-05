# https://leetcode.com/problems/strong-friendship/description/


import pandas as pd


def strong_friendship(friendship: pd.DataFrame) -> pd.DataFrame:
    friendship = pd.concat(
        (
            friendship,
            friendship.rename(columns={"user1_id": "user2_id", "user2_id": "user1_id"}),
        ),
        axis=0,
    ).sort_values(["user1_id", "user2_id"])

    tbl = (
        friendship.merge(friendship, how="cross")
        .query("user1_id_x < user1_id_y and user2_id_x == user2_id_y")
        .groupby(["user1_id_x", "user1_id_y"])
        .size()
        .rename("common_friend")
    )
    tbl.index = tbl.index.rename(["user1_id", "user2_id"])

    out = tbl[tbl >= 3].reset_index()
    cols = out.columns

    return out.merge(friendship, on=["user1_id", "user2_id"], suffixes=["", "_"])[cols]
