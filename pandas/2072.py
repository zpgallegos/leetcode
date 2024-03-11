# https://leetcode.com/problems/the-winner-university/description/

import pandas as pd


def find_winner(new_york: pd.DataFrame, california: pd.DataFrame) -> pd.DataFrame:
    ny = (new_york.score >= 90).sum()
    ca = (california.score >= 90).sum()

    out = (
        "New York University"
        if ny > ca
        else "California University" if ca > ny else "No Winner"
    )

    return pd.DataFrame({"winner": [out]})
