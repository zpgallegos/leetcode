# https://leetcode.com/problems/winning-candidate/description/


import pandas as pd


def winning_candidate(candidate: pd.DataFrame, vote: pd.DataFrame) -> pd.DataFrame:
    cnts = (
        vote.merge(candidate.rename(columns={"id": "candidateId"}), on="candidateId")
        .groupby("name")["id"]
        .nunique()
    )

    return pd.DataFrame(cnts[cnts == cnts.max()].index)
