# https://leetcode.com/problems/ad-free-sessions/description/


import pandas as pd


def ad_free_sessions(playback: pd.DataFrame, ads: pd.DataFrame) -> pd.DataFrame:
    shown = set(
        playback.merge(ads, on="customer_id")
        .query("timestamp >= start_time and timestamp <= end_time")
        .session_id
    )

    return pd.DataFrame({"session_id": list(set(playback.session_id) - shown)})
