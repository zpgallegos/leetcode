# https://leetcode.com/problems/find-overlapping-shifts-ii/description/


import pandas as pd


def calculate_shift_overlaps(employee_shifts: pd.DataFrame) -> pd.DataFrame:
    # this bug again lol
    employee_shifts["start_time"] = pd.to_datetime(employee_shifts["start_time"])
    employee_shifts["end_time"] = pd.to_datetime(employee_shifts["end_time"])

    d = employee_shifts.merge(
        employee_shifts, on="employee_id", suffixes=["_x", "_y"]
    ).query("start_time_x < start_time_y and start_time_y < end_time_x")
    d["length"] = (d.end_time_x - d.start_time_y).dt.total_seconds() / 60

    emps = employee_shifts["employee_id"].unique()

    q = (
        d.groupby(["employee_id", "start_time_x"])
        .size()
        .groupby("employee_id")
        .max()
        .reindex(emps, fill_value=0)
        .rename("max_overlapping_shifts")
        + 1
    )

    p = (
        d.groupby("employee_id")
        .length.sum()
        .rename("total_overlap_duration")
        .reindex(emps, fill_value=0)
    )

    return pd.concat([q, p], axis=1).reset_index()
