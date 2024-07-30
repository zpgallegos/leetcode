# https://leetcode.com/problems/leetcodify-similar-friends/description/

import pandas as pd


def leetcodify_similar_friends(
    listens: pd.DataFrame, friendship: pd.DataFrame
) -> pd.DataFrame:
    d = friendship.merge(listens, left_on="user1_id", right_on="user_id").merge(
        listens,
        left_on=["user2_id", "song_id", "day"],
        right_on=["user_id", "song_id", "day"],
    )

    cnts = d.groupby(["user1_id", "user2_id", "day"]).song_id.nunique()

    return cnts[cnts >= 3].reset_index()[["user1_id", "user2_id"]].drop_duplicates()
