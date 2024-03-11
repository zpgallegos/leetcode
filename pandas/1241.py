# https://leetcode.com/problems/number-of-comments-per-post/

import pandas as pd


def count_comments(submissions: pd.DataFrame) -> pd.DataFrame:
    return (
        submissions[submissions.parent_id.isnull()]
        .merge(
            submissions,
            how="left",
            left_on="sub_id",
            right_on="parent_id",
            suffixes=["_x", "_y"],
        )
        .groupby("sub_id_x")
        .sub_id_y.nunique()
        .reset_index()
        .rename(columns={"sub_id_x": "post_id", "sub_id_y": "number_of_comments"})
        .sort_values("post_id")
    )
