# https://leetcode.com/problems/all-the-pairs-with-the-maximum-number-of-common-followers/description/


import pandas as pd


def find_pairs(relations: pd.DataFrame) -> pd.DataFrame:
    d = (
        relations.merge(relations, on="follower_id", suffixes=["_a", "_b"])
        .query("user_id_a < user_id_b")
        .groupby(["user_id_a", "user_id_b"])
        .size()
    )
    out = d[d == d.max()]

    return out.reset_index()[["user_id_a", "user_id_b"]].rename(
        columns={"user_id_a": "user1_id", "user_id_b": "user2_id"}
    )
