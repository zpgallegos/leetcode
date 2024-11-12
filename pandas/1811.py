# https://leetcode.com/problems/find-interview-candidates/description/

import pandas as pd


def find_interview_candidates(
    contests: pd.DataFrame, users: pd.DataFrame
) -> pd.DataFrame:
    q1 = contests.gold_medal.value_counts()
    q1 = q1[q1 >= 3].index

    d = pd.concat(
        (
            contests[["contest_id", "gold_medal"]].rename(
                columns={"gold_medal": "user_id"}
            ),
            contests[["contest_id", "silver_medal"]].rename(
                columns={"silver_medal": "user_id"}
            ),
            contests[["contest_id", "bronze_medal"]].rename(
                columns={"bronze_medal": "user_id"}
            ),
        ),
        axis=0,
    ).sort_values(["user_id", "contest_id"])

    d["dif"] = (d.groupby("user_id").contest_id.diff(1) > 1).fillna(True)
    d["grp"] = d.dif.cumsum()

    cnt = d.groupby(["user_id", "grp"]).size()
    q2 = cnt[cnt >= 3].index.get_level_values("user_id")

    q = list(set(list(q1) + list(q2)))

    return users.set_index("user_id").loc[q]
