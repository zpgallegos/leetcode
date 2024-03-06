# https://leetcode.com/problems/reported-posts/

import pandas as pd


def reported_posts(actions: pd.DataFrame) -> pd.DataFrame:
    return (
        actions.query("action_date == '2019-07-04' and action == 'report'")
        .groupby("extra")
        .apply(lambda grp: grp.post_id.nunique())
        .reset_index()
        .rename(columns={"extra": "report_reason", 0: "report_count"})
    )
