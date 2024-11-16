# https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/


import pandas as pd


def count_employees(employees: pd.DataFrame) -> pd.DataFrame:
    return (
        employees.groupby("reports_to")
        .agg(
            reports_count=("employee_id", "nunique"),
            average_age=("age", lambda x: round(x.mean() + 1e-6)),
        )
        .reset_index()
        .rename(columns={"reports_to": "employee_id"})
        .merge(employees, on="employee_id")[
            ["employee_id", "name", "reports_count", "average_age"]
        ]
        .sort_values("employee_id")
    )
