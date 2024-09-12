# https://leetcode.com/problems/popularity-percentage/description/

import pandas as pd


def popularity_percentage(friends: pd.DataFrame) -> pd.DataFrame:
    d = pd.concat(
        (
            friends.rename(columns={"user2": "friend"}),
            friends[["user2", "user1"]].rename(
                columns={"user2": "user1", "user1": "friend"}
            ),
        ),
        axis=0,
    )

    return (
        ((d.groupby("user1").friend.nunique().sort_index() / d.user1.nunique()) * 100)
        .round(2)
        .rename("percentage_popularity")
        .reset_index()
    )
