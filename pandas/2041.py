# https://leetcode.com/problems/accepted-candidates-from-the-interviews/description/

import pandas as pd


def accepted_candidates(candidates: pd.DataFrame, rounds: pd.DataFrame) -> pd.DataFrame:
    d = (
        candidates.query("years_of_exp >= 2")
        .merge(rounds, on="interview_id")
        .groupby("candidate_id")
        .agg(total=("score", "sum"))
    )

    return pd.DataFrame(d[d.total > 15].index)
