# https://leetcode.com/problems/grand-slam-titles/


import pandas as pd


def grand_slam_titles(
    players: pd.DataFrame, championships: pd.DataFrame
) -> pd.DataFrame:
    return (
        championships.drop("year", axis=1)
        .melt(value_name="player_id")
        .player_id.value_counts()
        .rename("grand_slams_count")
        .reset_index()
        .merge(players, on="player_id")[
            ["player_id", "player_name", "grand_slams_count"]
        ]
    )
