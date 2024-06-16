# https://leetcode.com/problems/median-employee-salary/


import pandas as pd


def median_employee_salary(employee: pd.DataFrame) -> pd.DataFrame:
    employee["row_n"] = employee.groupby("company").salary.rank(method="first")

    vc = employee.company.value_counts()
    incl = vc.apply(lambda x: [x / 2, x / 2 + 1] if x % 2 == 0 else [x // 2 + 1])

    return employee[
        employee.apply(lambda row: row.row_n in incl[row.company], axis=1)
    ].drop("row_n", axis=1)
