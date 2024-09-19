# https://leetcode.com/problems/compute-the-rank-as-a-percentage/description/

import pandas as pd


def compute_rating(students: pd.DataFrame) -> pd.DataFrame:
    grp = students.groupby("department_id")
    dep_n = grp.department_id.transform("size")
    rnk = grp.mark.rank(ascending=False, method="min")

    students["percentage"] = (((rnk - 1) * 100) / (dep_n - 1).clip(1)).round(2)

    return students.drop("mark", axis=1)
