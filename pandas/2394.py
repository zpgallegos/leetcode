# https://leetcode.com/problems/employees-with-deductions/

import pandas as pd

from numpy import ceil


def employees_with_deductions(
    employees: pd.DataFrame, logs: pd.DataFrame
) -> pd.DataFrame:
    employees = employees.set_index("employee_id")

    logs["mins"] = ceil((logs.out_time - logs.in_time).dt.total_seconds() / 60)

    employees["hrs"] = (logs.groupby("employee_id").mins.sum() / 60).reindex(
        employees.index, fill_value=0
    )

    return pd.DataFrame(employees.loc[employees.hrs < employees.needed_hours].index)



# https://leetcode.com/problems/employees-with-deductions/description/

import numpy as np
import pandas as pd


def employees_with_deductions(
    employees: pd.DataFrame, logs: pd.DataFrame
) -> pd.DataFrame:
    logs["hours"] = np.ceil((logs.out_time - logs.in_time).dt.seconds / 60) / 60

    worked = logs.groupby("employee_id").hours.sum().rename("worked").reset_index()

    return (
        employees.merge(worked, on="employee_id", how="left")
        .fillna(0)
        .query("worked < needed_hours")[["employee_id"]]
    )
