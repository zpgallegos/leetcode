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
