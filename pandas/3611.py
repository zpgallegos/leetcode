# https://leetcode.com/problems/find-overbooked-employees/

import pandas as pd


def find_overbooked_employees(
    employees: pd.DataFrame, meetings: pd.DataFrame
) -> pd.DataFrame:

    meetings = meetings.assign(week=meetings.meeting_date.dt.strftime("%Y-%W"))

    return (
        meetings.groupby(["employee_id", "week"], as_index=False)
        .duration_hours.sum()
        .query("duration_hours > 20")
        .groupby("employee_id", as_index=False)
        .size()
        .rename(columns={"size": "meeting_heavy_weeks"})
        .query("meeting_heavy_weeks > 1")
        .merge(employees, on="employee_id")
        .sort_values(["meeting_heavy_weeks", "employee_name"], ascending=[False, True])[
            ["employee_id", "employee_name", "department", "meeting_heavy_weeks"]
        ]
    )
