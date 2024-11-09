# https://leetcode.com/problems/group-employees-of-the-same-salary/description/

import pandas as pd


def employees_of_same_salary(employees: pd.DataFrame) -> pd.DataFrame:
    cnts = employees.salary.value_counts()
    rem = set(cnts[cnts == 1].index)
    employees = employees[~employees.salary.isin(rem)]
    employees["team_id"] = employees.salary.rank(method="dense")
    return employees.sort_values(["team_id", "employee_id"])
