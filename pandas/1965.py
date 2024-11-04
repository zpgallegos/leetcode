# https://leetcode.com/problems/employees-with-missing-information/

import pandas as pd


def find_employees(employees: pd.DataFrame, salaries: pd.DataFrame) -> pd.DataFrame:
    d = (
        employees.merge(salaries, on="employee_id", how="outer")
        .set_index("employee_id")
        .sort_index()
    )
    return pd.DataFrame(d[d.isna().sum(axis=1) > 0].index)
