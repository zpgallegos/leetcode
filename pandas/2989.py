# https://leetcode.com/problems/class-performance/

import pandas as pd


def class_performance(scores: pd.DataFrame) -> pd.DataFrame:
    tbl = scores[["assignment1", "assignment2", "assignment3"]].sum(axis=1)
    return pd.DataFrame({"difference_in_score": [tbl.max() - tbl.min()]})
