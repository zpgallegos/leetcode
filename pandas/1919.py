# https://leetcode.com/problems/leetcodify-similar-friends/description/


import pandas as pd


def leetcodify_similar_friends(
    listens: pd.DataFrame, friendship: pd.DataFrame
) -> pd.DataFrame:
    tbl = (
        listens.merge(friendship, left_on="user_id", right_on="user1_id")
        .merge(
            listens,
            left_on=["user2_id", "day", "song_id"],
            right_on=["user_id", "day", "song_id"],
        )
        .groupby(["user1_id", "user2_id", "day"])
        .song_id.nunique()
        .rename("cnt")
    )

    return tbl[tbl >= 3].reset_index()[["user1_id", "user2_id"]].drop_duplicates()
