# https://leetcode.com/problems/find-students-who-improved/


import pandas as pd


def find_students_who_improved(scores: pd.DataFrame) -> pd.DataFrame:
    ids = ["student_id", "subject"]
    scores = scores.sort_values([*ids, "exam_date"])

    out = []
    for idx, grp in scores.groupby(ids):
        first = grp.score.iloc[0]
        last = grp.score.iloc[-1]

        if last > first:
            out.append([*idx, first, last])

    return pd.DataFrame(
        out, columns=["student_id", "subject", "first_score", "latest_score"]
    )
