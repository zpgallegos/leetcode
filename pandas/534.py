# https://leetcode.com/problems/game-play-analysis-iii/?lang=pythondata?envType=daily-question&envId=2023-09-01

import pandas as pd

def gameplay_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    id_cols = ["player_id", "event_date"]
    out_col =  "games_played_so_far"
    
    activity = activity.sort_values(id_cols)
    activity[out_col] = activity.groupby("player_id").games_played.cumsum()

    return activity[id_cols + [out_col]]