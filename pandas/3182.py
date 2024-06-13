# https://leetcode.com/problems/find-top-scoring-students/description/


import pandas as pd


def find_top_scoring_students(
    enrollments: pd.DataFrame, students: pd.DataFrame, courses: pd.DataFrame
) -> pd.DataFrame:
    cnts = courses.groupby("major").size()

    tbl = (
        students.merge(courses, on="major")
        .merge(enrollments, on=["student_id", "course_id"])
        .groupby(["student_id", "major"])
        .agg(taken=("course_id", "count"), avg=("grade", lambda x: (x == "A").mean()))
    )
    tbl["major_count"] = tbl.index.get_level_values("major").map(cnts)

    return (
        tbl[(tbl.taken == tbl.major_count) & (tbl.avg == 1)]
        .reset_index()[["student_id"]]
        .sort_values("student_id")
    )
