# https://leetcode.com/problems/department-highest-salary/?lang=pythondata?envType=daily-question&envId=2023-09-01

import pandas as pd


def department_highest_salary(
    employee: pd.DataFrame, department: pd.DataFrame
) -> pd.DataFrame:
    employee = employee.rename(columns={"name": "Employee", "salary": "Salary"})
    department = department.rename(columns={"name": "Department"})

    d = employee.merge(department, left_on="departmentId", right_on="id")
    mx = d.groupby("departmentId").Salary.max().reset_index()
    return d.merge(mx, on=["departmentId", "Salary"])[
        ["Department", "Employee", "Salary"]
    ]


def department_highest_salary(
    employee: pd.DataFrame, department: pd.DataFrame
) -> pd.DataFrame:
    out_cols = ["Department", "Employee", "Salary"]

    if not employee.shape[0] or not department.shape[0]:
        return pd.DataFrame(None, columns=out_cols)
    
    employee = employee.rename(columns={"name": "Employee", "salary": "Salary"})
    department = department.rename(columns={"name": "Department"})

    d = employee.merge(department, left_on="departmentId", right_on="id")
    mask = d.groupby("departmentId").Salary.transform(lambda s: s == s.max())

    return d[mask][["Department", "Employee", "Salary"]]
