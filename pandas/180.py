# https://leetcode.com/problems/consecutive-numbers/

import pandas as pd


def consecutive_numbers(logs: pd.DataFrame) -> pd.DataFrame:
    mn = 3

    logs["grp"] = (logs.num != logs.num.shift(1)).fillna(True).astype(int).cumsum()
    vc = logs.grp.value_counts()

    return (
        logs.loc[logs.grp.isin(vc[vc >= mn].index), ["num"]]
        .drop_duplicates()
        .rename(columns={"num": "ConsecutiveNums"})
    )
