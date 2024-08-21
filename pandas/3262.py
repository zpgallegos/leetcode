# https://leetcode.com/problems/find-overlapping-shifts/description/


import pandas as pd


def find_overlapping_shifts(employee_shifts: pd.DataFrame) -> pd.DataFrame:
    return (
        employee_shifts.merge(employee_shifts, on="employee_id", suffixes=["_x", "_y"])
        .query("start_time_x < start_time_y and end_time_x > start_time_y")
        .employee_id.value_counts()
        .rename("overlapping_shifts")
        .sort_index()
        .reset_index()
    )
