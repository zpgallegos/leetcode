# https://leetcode.com/problems/tournament-winners/


import pandas as pd


def tournament_winners(players: pd.DataFrame, matches: pd.DataFrame) -> pd.DataFrame:
    def select(x: str) -> pd.DataFrame:
        out = matches[[f"{x}_{col}" for col in ("player", "score")]]
        out.columns = ["player_id", "score"]
        return out

    q = (
        pd.concat((select("first"), select("second")), axis=0)
        .merge(players, on="player_id")
        .groupby(["group_id", "player_id"])
        .score.sum()
        .rename("player_total")
        .reset_index()
        .sort_values(
            ["group_id", "player_total", "player_id"], ascending=[True, False, True]
        )
    )

    return q[q.groupby("group_id").cumcount() == 0][["group_id", "player_id"]]
