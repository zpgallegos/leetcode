# https://leetcode.com/problems/biggest-window-between-visits/description/


import pandas as pd


def biggest_window(user_visits: pd.DataFrame) -> pd.DataFrame:
    today = pd.Timestamp(2021, 1, 1)
    app = pd.DataFrame(
        {
            "user_id": user_visits.user_id.unique(),
            "visit_date": today,
        }
    )
    user_visits = pd.concat((user_visits, app), axis=0).sort_values(
        ["user_id", "visit_date"]
    )
    user_visits["dif"] = user_visits.groupby("user_id").visit_date.diff(1).dt.days

    return (
        user_visits.groupby("user_id")
        .dif.max()
        .rename("biggest_window")
        .sort_index()
        .reset_index()
    )
