# https://leetcode.com/problems/rank-scores/?lang=pythondata

import pandas as pd


def order_scores(scores: pd.DataFrame) -> pd.DataFrame:
    scores = scores.sort_values("score", ascending=False)
    scores["rank"] = scores.score.rank(method="dense", ascending=False)
    return scores[["score", "rank"]]
