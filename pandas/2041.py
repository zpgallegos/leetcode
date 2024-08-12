# https://leetcode.com/problems/accepted-candidates-from-the-interviews/


import pandas as pd


def accepted_candidates(candidates: pd.DataFrame, rounds: pd.DataFrame) -> pd.DataFrame:
    d = (
        candidates.query("years_of_exp >= 2")
        .merge(rounds, on="interview_id")
        .groupby("candidate_id")
        .score.sum()
    )

    return pd.DataFrame(d[d > 15].index)
