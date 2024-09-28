# https://leetcode.com/problems/the-change-in-global-rankings/description/


import pandas as pd


def global_ratings_change(
    team_points: pd.DataFrame, points_change: pd.DataFrame
) -> pd.DataFrame:
    team_points = team_points.merge(points_change, on="team_id", how="left")
    team_points["pts"] = team_points.points + team_points.points_change.fillna(0)

    def get_rank(col: str) -> pd.Series:
        return team_points.sort_values([col, "name"], ascending=[False, True])[
            col
        ].rank(method="first", ascending=False)

    team_points["rank_diff"] = get_rank("points") - get_rank("pts")

    return team_points[["team_id", "name", "rank_diff"]]
