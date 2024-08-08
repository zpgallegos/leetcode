# https://leetcode.com/problems/finding-the-topic-of-each-post/description/

import pandas as pd


def calculate_team_standings(team_stats: pd.DataFrame) -> pd.DataFrame:
    p = (
        team_stats.groupby(["team_id", "team_name"])
        .apply(lambda grp: (grp.wins * 3).sum() + grp.draws.sum())
        .rename("points")
        .reset_index()
    )
    p["position"] = p.points.rank(method="min", ascending=False)

    return p.sort_values(["position", "team_name"])
