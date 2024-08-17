# https://leetcode.com/problems/premier-league-table-ranking-ii/description/


import pandas as pd

from math import ceil


def calculate_team_tiers(team_stats: pd.DataFrame) -> pd.DataFrame:
    team_stats["points"] = team_stats.apply(
        lambda row: row.wins * 3 + row.draws, axis=1
    )

    p = (
        team_stats.groupby("team_name")
        .points.sum()
        .reset_index()
        .sort_values(["points", "team_name"], ascending=[False, True])
    )
    p["position"] = p.points.rank(method="min", ascending=False)

    lower, upper = p.position.quantile([0.33, 0.66])

    p["tier"] = p.position.apply(
        lambda x: (
            "Tier 1" if x <= ceil(lower) else "Tier 2" if x <= ceil(upper) else "Tier 3"
        )
    )

    return p
