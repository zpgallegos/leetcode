# https://leetcode.com/problems/find-cutoff-score-for-each-school/description/

import pandas as pd


def find_cutoff_score(schools: pd.DataFrame, exam: pd.DataFrame) -> pd.DataFrame:
    def assign_min_score(capacity: int) -> int:
        d = exam.loc[exam.student_count <= capacity, "score"]
        return -1 if d.empty else d.min()

    schools["score"] = schools.capacity.apply(assign_min_score)

    return schools[["school_id", "score"]]
