# https://leetcode.com/problems/create-a-session-bar-chart/description/

import pandas as pd

CATS = {
    "[0-5>": 5,
    "[5-10>": 10,
    "[10-15>": 15,
    "15 or more": None,
}


def classify(mins):
    for lab, lim in CATS.items():
        if not lim or mins < lim:
            return lab
    return None


def create_bar_chart(sessions: pd.DataFrame) -> pd.DataFrame:
    cat = pd.CategoricalDtype(CATS, ordered=True)

    return (
        (sessions.duration / 60)
        .apply(classify)
        .astype(cat)
        .value_counts()
        .reset_index()
        .rename(columns={"duration": "bin", "count": "total"})
    )
