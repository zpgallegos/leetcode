# https://leetcode.com/problems/page-recommendations-ii/description/


import pandas as pd


def recommend_page(friendship: pd.DataFrame, likes: pd.DataFrame) -> pd.DataFrame:
    friendship = pd.concat(
        (
            friendship.rename(columns={"user1_id": "main_id", "user2_id": "friend_id"}),
            friendship.rename(columns={"user2_id": "main_id", "user1_id": "friend_id"}),
        ),
        axis=0,
    )

    return (
        friendship.merge(likes, left_on="friend_id", right_on="user_id")
        .groupby(["main_id", "page_id"])
        .user_id.nunique()
        .drop(pd.MultiIndex.from_frame(likes), errors="ignore")
        .reset_index()
        .rename(columns={"main_id": "user_id", "user_id": "friends_likes"})
    )
