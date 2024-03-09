# https://leetcode.com/problems/employees-project-allocation/description/

import pandas as pd


def employees_with_above_avg_workload(
    project: pd.DataFrame, employees: pd.DataFrame
) -> pd.DataFrame:

    d = project.merge(employees, on="employee_id")
    d["team_avg"] = d.groupby("team").workload.transform("mean")

    return (
        d[d.workload > d.team_avg][["employee_id", "project_id", "name", "workload"]]
        .sort_values(["employee_id", "project_id"])
        .rename(columns={"name": "employee_name", "workload": "project_workload"})
    )
