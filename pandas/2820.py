# https://leetcode.com/problems/election-results/


import pandas as pd


def get_election_results(votes: pd.DataFrame) -> pd.DataFrame:
    votes["votes"] = 1 / votes.groupby("voter").voter.transform(len)
    tot = votes.groupby("candidate").votes.sum()
    return pd.DataFrame(tot[tot == tot.max()].index)
