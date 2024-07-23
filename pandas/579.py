# https://leetcode.com/problems/find-cumulative-salary-of-an-employee/description/

import pandas as pd


def cumulative_salary(employee: pd.DataFrame) -> pd.DataFrame:
    d = employee[employee.groupby("id").month.rank(ascending=False) > 1].sort_values(
        ["id", "month"]
    )

    def f(row, i):
        m = getattr(row, f"m_{i}")
        s = getattr(row, f"s_{i}")
        return 0 if pd.isnull(m) or m + i != row.month else s

    grp = d.groupby("id")
    for i in (1, 2):
        d[f"m_{i}"] = grp.month.shift(i)
        d[f"s_{i}"] = grp.salary.shift(i)
        d[f"x_{i}"] = d.apply(lambda row: f(row, i), axis=1)

    d["Salary"] = d.x_1 + d.x_2 + d.salary

    return d[["id", "month", "Salary"]].sort_values(
        ["id", "month"], ascending=[True, False]
    )
