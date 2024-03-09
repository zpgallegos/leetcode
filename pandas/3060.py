# https://leetcode.com/problems/user-activities-within-time-bounds/description/

import pandas as pd

sessions = pd.read_csv("data.csv")
sessions["session_start"] = pd.to_datetime(sessions.session_start)
sessions["session_end"] = pd.to_datetime(sessions.session_end)


def user_activities(sessions: pd.DataFrame) -> pd.DataFrame:
    # sessions = sessions.sort_values(["user_id", "session_start"])

    # sessions["type_matches"] = sessions.session_type == sessions.session_type.shift(1)
    # sessions["within_time"] = (
    #     sessions.session_start - sessions.session_end.shift(1)
    # ).dt.total_seconds() / 60 / 60 <= 12

    # sessions can be overlapping??
    # this gets accepted LOL terrible problem

    d = sessions.merge(sessions, how="cross", suffixes=["_x", "_y"])

    return (
        d[
            (d.user_id_x == d.user_id_y)
            & (d.session_id_x != d.session_id_y)
            & (d.session_type_x == d.session_type_y)
            & (d.session_start_x > d.session_start_y)
            & ((d.session_start_x - d.session_end_y).dt.total_seconds() / 60 / 60 <= 12)
        ][["user_id_x"]]
        .drop_duplicates()
        .sort_values("user_id_x")
        .rename(columns={"user_id_x": "user_id"})
    )
