# https://leetcode.com/problems/department-top-three-salaries/

import pandas as pd


def top_three_salaries(
    employee: pd.DataFrame, department: pd.DataFrame
) -> pd.DataFrame:
    employee["rnk"] = employee.groupby("departmentId").salary.rank(
        method="dense", ascending=False
    )

    return (
        employee[employee.rnk <= 3]
        .merge(
            department, left_on="departmentId", right_on="id", suffixes=["_x", "_y"]
        )[["name_y", "name_x", "salary"]]
        .rename(
            columns={"name_y": "Department", "name_x": "Employee", "salary": "Salary"}
        )
    )
