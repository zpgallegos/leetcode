# https://leetcode.com/problems/students-with-invalid-departments/submissions/1198797380/

import pandas as pd


def find_students(departments: pd.DataFrame, students: pd.DataFrame) -> pd.DataFrame:
    deps = set(departments.id)

    return students.loc[~students.department_id.isin(deps), ["id", "name"]]
