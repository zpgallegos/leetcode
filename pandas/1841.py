# https://leetcode.com/problems/league-statistics/description/

import pandas as pd


def league_statistics(teams: pd.DataFrame, matches: pd.DataFrame) -> pd.DataFrame:
    gls = ["home_team_goals", "away_team_goals"]

    tbl = pd.concat(
        (
            matches[["home_team_id"] + gls].rename(
                columns={
                    "home_team_id": "team_id",
                    "home_team_goals": "goals_for",
                    "away_team_goals": "goals_against",
                }
            ),
            matches[["away_team_id"] + gls].rename(
                columns={
                    "away_team_id": "team_id",
                    "away_team_goals": "goals_for",
                    "home_team_goals": "goals_against",
                }
            ),
        ),
        axis=0,
    ).merge(teams, on="team_id")

    tbl["points"] = tbl.apply(
        lambda row: (
            3
            if row.goals_for > row.goals_against
            else 1 if row.goals_for == row.goals_against else 0
        ),
        axis=1,
    )

    agg = tbl.groupby("team_name").agg(
        matches_played=("team_id", len),
        points=("points", "sum"),
        goal_for=("goals_for", "sum"),
        goal_against=("goals_against", "sum"),
    )
    agg["goal_diff"] = agg.goal_for - agg.goal_against

    return agg.sort_values(
        ["points", "goal_diff", "team_name"], ascending=[False, False, True]
    ).reset_index()
