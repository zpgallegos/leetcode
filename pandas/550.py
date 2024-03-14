# https://leetcode.com/problems/game-play-analysis-iv/description/

import pandas as pd


def gameplay_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    activity = activity.sort_values(["player_id", "event_date"])
    activity["rnk"] = activity.groupby("player_id").event_date.rank(method="dense")
    activity["dif"] = (
        activity.groupby("player_id").event_date.diff(1).dt.days.astype("Int64")
    )

    return pd.DataFrame(
        {
            "fraction": round(
                activity[(activity.rnk == 2) & (activity.dif == 1)].player_id.nunique()
                / activity.player_id.nunique(),
                2,
            )
        },
        index=[0],
    )


def gameplay_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    jn = activity.groupby("player_id").event_date.min() + pd.Timedelta(days=1)

    num = activity.merge(
        jn.reset_index(), on=["player_id", "event_date"]
    ).player_id.nunique()
    denom = activity.player_id.nunique()

    return pd.DataFrame({"fraction": [round(num / denom, 2)]})
