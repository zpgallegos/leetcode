# https://leetcode.com/problems/leetcodify-friends-recommendations/description/


import pandas as pd


def recommend_friends(listens: pd.DataFrame, friendship: pd.DataFrame) -> pd.DataFrame:
    tbl = (
        listens.merge(listens, on=["song_id", "day"], suffixes=["_x", "_y"])
        .query("user_id_x < user_id_y")
        .groupby(["user_id_x", "user_id_y", "day"])
        .song_id.nunique()
    )

    out = (
        tbl[tbl >= 3]
        .reset_index()[["user_id_x", "user_id_y"]]
        .drop_duplicates()
        .rename(columns={"user_id_x": "user1_id", "user_id_y": "user2_id"})
        .merge(friendship, on=["user1_id", "user2_id"], how="left", indicator=True)
        .query("_merge == 'left_only'")
        .drop("_merge", axis=1)
    )

    return pd.concat(
        (
            out.rename(columns={"user1_id": "user_id", "user2_id": "recommended_id"}),
            out.rename(columns={"user2_id": "user_id", "user1_id": "recommended_id"}),
        ),
        axis=0,
    )
