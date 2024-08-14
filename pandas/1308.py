# https://leetcode.com/problems/running-total-for-different-genders/

import pandas as pd


def running_total(scores: pd.DataFrame) -> pd.DataFrame:
    scores = scores.sort_values(["gender", "day"])
    scores["total"] = scores.groupby("gender").score_points.cumsum()

    return scores[["gender", "day", "total"]]
