# https://leetcode.com/problems/page-recommendations-ii/


import pandas as pd


def recommend_page(friendship: pd.DataFrame, likes: pd.DataFrame) -> pd.DataFrame:
    friends = pd.concat(
        (
            friendship.rename(columns={"user1_id": "user_id", "user2_id": "friend_id"}),
            friendship.rename(columns={"user2_id": "user_id", "user1_id": "friend_id"}),
        ),
        axis=0,
    )

    flc = (
        friends.merge(likes, left_on="friend_id", right_on="user_id")
        .groupby(["user_id_x", "page_id"])
        .size()
        .rename("friends_likes")
    )
    flc.index = flc.index.rename({"user_id_x": "user_id"})

    mdx = pd.MultiIndex.from_frame(likes)

    return flc.drop(mdx, errors="ignore").reset_index()
