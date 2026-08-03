# https://leetcode.com/problems/find-zombie-sessions/


import pandas as pd


def find_zombie_sessions(app_events: pd.DataFrame) -> pd.DataFrame:

    app_events = app_events.assign(
        event_timestamp=pd.to_datetime(app_events["event_timestamp"])
    )

    return (
        app_events.groupby(["user_id", "session_id"], as_index=False)
        .agg(
            first_event=("event_timestamp", "min"),
            last_event=("event_timestamp", "max"),
            scroll_count=("event_type", lambda s: s.eq("scroll").sum()),
            click_count=("event_type", lambda s: s.eq("click").sum()),
            purchase_count=("event_type", lambda s: s.eq("purchase").sum()),
        )
        .assign(
            session_duration_minutes=lambda df: (df["last_event"] - df["first_event"])
            .dt.total_seconds()
            .div(60),
        )
        .query(
            "session_duration_minutes > 30"
            " and scroll_count >= 5"
            " and click_count < 0.2 * scroll_count"
            " and purchase_count == 0"
        )
        .sort_values(["scroll_count", "session_id"], ascending=[False, True])[
            ["session_id", "user_id", "session_duration_minutes", "scroll_count"]
        ]
    )
