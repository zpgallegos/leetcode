# https://leetcode.com/problems/find-the-quiet-students-in-all-exams/


import pandas as pd


def find_quiet_students(student: pd.DataFrame, exam: pd.DataFrame) -> pd.DataFrame:
    exam["loud"] = exam.groupby("exam_id").score.transform(
        lambda x: (x == x.max()) | (x == x.min())
    )
    cnts = exam.groupby("student_id").loud.sum()
    quiet = set(cnts[cnts == 0].index)

    return student[student.student_id.isin(quiet)][["student_id", "student_name"]]
