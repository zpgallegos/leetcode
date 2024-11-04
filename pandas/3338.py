# https://leetcode.com/problems/second-highest-salary-ii/description/

import pandas as pd


def find_second_highest_salary(employees: pd.DataFrame) -> pd.DataFrame:
    employees["rnk"] = employees.groupby("dept").salary.rank(
        ascending=False,
        method="dense",
    )
    return employees.loc[employees.rnk == 2, ["emp_id", "dept"]].sort_values("emp_id")
