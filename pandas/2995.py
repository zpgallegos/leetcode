# https://leetcode.com/problems/viewers-turned-streamers/description/

import pandas as pd


def count_turned_streamers(sessions: pd.DataFrame) -> pd.DataFrame:
    sessions = sessions.sort_values(["user_id", "session_start"])

    sessions["rw"] = sessions.groupby("user_id").cumcount()
    incl = set(
        sessions[(sessions.rw == 0) & (sessions.session_type == "Viewer")].user_id
    )

    return (
        sessions[sessions.user_id.isin(incl) & (sessions.session_type == "Streamer")]
        .user_id.value_counts()
        .reset_index(name="sessions_count")
        .rename(columns={"index": "user_id"})
        .sort_values(["sessions_count", "user_id"], ascending=[False, False])
    )
