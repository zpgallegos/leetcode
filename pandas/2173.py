# https://leetcode.com/problems/longest-winning-streak/description/


import pandas as pd


def longest_winning_streak(matches: pd.DataFrame) -> pd.DataFrame:
    matches = matches.sort_values(["player_id", "match_day"])

    matches["last_result"] = matches.groupby("player_id").result.shift(1)
    matches["incr"] = matches.apply(
        lambda row: (0 if row.last_result == "Win" and row.result == "Win" else 1),
        axis=1,
    )
    matches["grp"] = matches.incr.cumsum()

    return (
        matches.query("result == 'Win'")
        .groupby(["player_id", "grp"])
        .size()
        .groupby("player_id")
        .max()
        .reindex(matches.player_id.unique(), fill_value=0)
        .rename("longest_streak")
        .reset_index()
    )
