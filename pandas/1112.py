# https://leetcode.com/problems/highest-grade-for-each-student/?lang=pythondata

import pandas as pd


def highest_grade(enrollments: pd.DataFrame) -> pd.DataFrame:
    enrollments = enrollments.sort_values(
        ["student_id", "grade", "course_id"], ascending=[True, False, True]
    )
    q = enrollments.groupby("student_id").cumcount()
    return enrollments[q == 0]
