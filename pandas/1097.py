# https://leetcode.com/problems/game-play-analysis-v/description/

import numpy as np
import pandas as pd


def gameplay_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    d = (
        activity.groupby("player_id")
        .event_date.min()
        .reset_index()
        .rename(columns={"event_date": "install_dt"})
    )
    d["next_date"] = d.install_dt + pd.DateOffset(days=1)

    i = d.groupby("install_dt").player_id.nunique()
    i.name = "installs"

    r = (
        d.merge(
            activity,
            left_on=["player_id", "next_date"],
            right_on=["player_id", "event_date"],
        )
        .groupby("install_dt")
        .player_id.nunique()
    )
    r.name = "retained"

    q = pd.concat([i, r], axis=1).fillna(0).reset_index()
    q["Day1_retention"] = ((q.retained / q.installs) + 1e-6).round(2)

    return q.drop("retained", axis=1)
