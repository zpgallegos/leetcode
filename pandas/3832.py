# https://leetcode.com/problems/find-users-with-persistent-behavior-patterns/description/

import pandas as pd


def find_behaviorally_stable_users(activity: pd.DataFrame) -> pd.DataFrame:

    activity = activity.assign(action_date=pd.to_datetime(activity["action_date"]))

    return (
        activity.sort_values(["user_id", "action_date"])
        .assign(
            day_gap=lambda df: (
                df["action_date"] - df.groupby("user_id")["action_date"].shift(1)
            ).dt.days,
            last_action=lambda df: df.groupby("user_id")["action"].shift(1),
            incr=lambda df: 1
            - ((df["day_gap"] == 1) & (df["action"].eq(df["last_action"]))).astype(int),
            grp=lambda df: df.groupby("user_id")["incr"].cumsum(),
        )
        .groupby(["user_id", "action", "grp"], as_index=False)
        .agg(
            streak_length=("user_id", "size"),
            start_date=("action_date", "min"),
            end_date=("action_date", "max"),
        )
        .query("streak_length >= 5")
        .sort_values(["streak_length", "user_id"], ascending=[False, True])[
            ["user_id", "action", "streak_length", "start_date", "end_date"]
        ]
    )
