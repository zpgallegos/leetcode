# https://leetcode.com/problems/activity-participants/


import pandas as pd


def activity_participants(
    friends: pd.DataFrame, activities: pd.DataFrame
) -> pd.DataFrame:
    cnts = friends.activity.value_counts().reindex(
        activities.name.unique(), fill_value=0
    )

    return pd.DataFrame(cnts[(cnts < cnts.max()) * (cnts > cnts.min())].index)
