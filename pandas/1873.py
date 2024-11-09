# https://leetcode.com/problems/calculate-special-bonus/description/

import pandas as pd


def calculate_special_bonus(employees: pd.DataFrame) -> pd.DataFrame:
    employees = employees.rename(columns={"name": "emp_name"})
    employees["bonus"] = employees.apply(
        lambda row: (
            row.salary if row.employee_id % 2 == 1 and row.emp_name[0] != "M" else 0
        ),
        axis=1,
    )
    return employees[["employee_id", "bonus"]].sort_values("employee_id")
