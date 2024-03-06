# https://leetcode.com/problems/friends-with-no-mutual-friends/solutions/4802541/self-join-xxx-xxx-not-in/

import pandas as pd


def friends_with_no_mutual_friends(friends: pd.DataFrame) -> pd.DataFrame:
    mp = (
        pd.concat(
            (
                friends,
                friends[["user_id2", "user_id1"]].rename(
                    columns={"user_id2": "user_id1", "user_id1": "user_id2"}
                ),
            ),
            axis=0,
        )
        .groupby("user_id1")
        .user_id2.apply(set)
    )

    def include(row):
        return not mp[row.user_id1].intersection(mp[row.user_id2])

    return friends[friends.apply(include, axis=1)].sort_values(["user_id1", "user_id2"])
