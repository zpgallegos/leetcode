# https://leetcode.com/problems/premier-league-table-ranking-iii/


import pandas as pd

data = [
    [2021, 1, "Manchester City", 38, 29, 6, 3, 99, 26],
    [2021, 2, "Liverpool", 38, 28, 8, 2, 94, 26],
    [2021, 3, "Chelsea", 38, 21, 11, 6, 76, 33],
    [2021, 4, "Tottenham", 38, 22, 5, 11, 69, 40],
    [2021, 5, "Arsenal", 38, 22, 3, 13, 61, 48],
    [2022, 1, "Manchester City", 38, 28, 5, 5, 94, 33],
    [2022, 2, "Arsenal", 38, 26, 6, 6, 88, 43],
    [2022, 3, "Manchester United", 38, 23, 6, 9, 58, 43],
    [2022, 4, "Newcastle", 38, 19, 14, 5, 68, 33],
    [2022, 5, "Liverpool", 38, 19, 10, 9, 75, 47],
]
season_stats = pd.DataFrame(
    data,
    columns=[
        "season_id",
        "team_id",
        "team_name",
        "matches_played",
        "wins",
        "draws",
        "losses",
        "goals_for",
        "goals_against",
    ],
)


def process_team_standings(season_stats: pd.DataFrame) -> pd.DataFrame:
    season_stats["points"] = season_stats.wins * 3 + season_stats.draws
    season_stats["dif"] = season_stats.goals_for - season_stats.goals_against

    tbl = (
        season_stats.groupby(["season_id", "team_id", "team_name"])
        .agg(points=("points", "sum"), goal_difference=("dif", "sum"))
        .sort_values(
            ["season_id", "points", "goal_difference", "team_name"],
            ascending=[True, False, False, True],
        )
    )
    tbl["position"] = tbl.groupby("season_id").cumcount() + 1

    season_stats.groupby(["season_id", "team_id", "team_name"]).agg(points=lambda x: (x.wins * 3 + x.draws).sum())

    return tbl.reset_index()
