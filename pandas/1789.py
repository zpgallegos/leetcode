# https://leetcode.com/problems/primary-department-for-each-employee/description/

import pandas as pd


def find_primary_department(employee: pd.DataFrame) -> pd.DataFrame:
    employee["cnt"] = employee.groupby("employee_id").employee_id.transform("count")

    return employee.query("cnt == 1 or primary_flag == 'Y'")[
        ["employee_id", "department_id"]
    ]
