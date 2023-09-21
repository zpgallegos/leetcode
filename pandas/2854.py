# https://leetcode.com/problems/rolling-average-steps/description/


import pandas as pd


def rolling_average(steps: pd.DataFrame) -> pd.DataFrame:
    idx_cols = ["user_id", "steps_date"]
    out_cols = idx_cols + ["rolling_average"]

    steps = steps.sort_values(idx_cols)
    grp = steps.groupby("user_id")

    steps["diff_2day"] = (steps.steps_date - grp.steps_date.shift(2)).dt.days
    steps["rolling_average"] = grp.rolling(3).steps_count.mean().round(2).values
    return steps.loc[steps.diff_2day == 2, out_cols]
