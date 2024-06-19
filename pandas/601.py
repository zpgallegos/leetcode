# https://leetcode.com/problems/human-traffic-of-stadium/


import pandas as pd


def human_traffic(stadium: pd.DataFrame) -> pd.DataFrame:
    stadium = stadium[stadium.people >= 100].copy()
    stadium["grp"] = stadium.id.diff(1).ne(1).fillna(True).astype(int).cumsum()

    vc = stadium.grp.value_counts()
    keep = vc[vc >= 3].index

    return stadium[stadium.grp.isin(keep)].drop("grp", axis=1).sort_values("visit_date")
