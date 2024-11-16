# https://leetcode.com/problems/find-followers-count/description/


import pandas as pd


def count_followers(followers: pd.DataFrame) -> pd.DataFrame:
    return (
        followers.user_id.value_counts()
        .rename("followers_count")
        .reset_index()
        .sort_values("user_id")
    )
