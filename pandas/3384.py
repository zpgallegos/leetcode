# https://leetcode.com/problems/team-dominance-by-pass-success/description/

import pandas as pd


def time_to_half(time: str) -> int:
    min, sec = time.split(":")
    num = int(min) + int(sec) / 60
    return 1 if num <= 45 else 2


def calculate_team_dominance(teams: pd.DataFrame, passes: pd.DataFrame) -> pd.DataFrame:
    team_map = teams.set_index("player_id").team_name.to_dict()

    passes["half_number"] = passes.time_stamp.apply(time_to_half)
    passes["team_name"] = passes.pass_from.map(team_map)
    passes["pass_to_team"] = passes.pass_to.map(team_map)
    passes["dominance"] = passes.apply(
        lambda row: 1 if row.team_name == row.pass_to_team else -1, axis=1
    )

    return (
        passes.groupby(["team_name", "half_number"])
        .dominance.sum()
        .sort_index()
        .reset_index()
    )
