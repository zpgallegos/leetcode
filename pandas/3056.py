# https://leetcode.com/problems/snaps-analysis/

import pandas as pd


def snap_analysis(activities: pd.DataFrame, age: pd.DataFrame) -> pd.DataFrame:
    tbl1 = (
        activities.merge(age, on="user_id")
        .groupby(["age_bucket", "activity_type"])
        .time_spent.sum()
    )
    tbl2 = tbl1.groupby("age_bucket").sum()

    out = (
        ((tbl1 / tbl2) * 100)
        .round(2)
        .reset_index()
        .pivot(index="age_bucket", columns="activity_type", values="time_spent")
        .fillna(0)
    )
    out.columns = (f"{col}_perc" for col in out.columns)

    return out.reset_index()
