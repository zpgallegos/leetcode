# https://leetcode.com/problems/find-total-time-spent-by-each-employee/description/


import pandas as pd


def total_time(employees: pd.DataFrame) -> pd.DataFrame:
    return (
        employees.groupby(["event_day", "emp_id"])
        .apply(lambda x: (x.out_time - x.in_time).sum())
        .rename("total_time")
        .reset_index()
        .rename(columns={"event_day": "day"})
    )
