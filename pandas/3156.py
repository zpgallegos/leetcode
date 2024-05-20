# https://leetcode.com/problems/employee-task-duration-and-concurrent-tasks/

import numpy as np
import pandas as pd


def find_total_duration(tasks: pd.DataFrame) -> pd.DataFrame:
    IDX = ["employee_id", "task_id"]
    EMPS = set(tasks.employee_id)

    tasks["task_duration"] = (tasks.end_time - tasks.start_time).dt.total_seconds()

    overlap = (
        tasks.merge(tasks, on="employee_id", suffixes=("_a", "_b"))
        .query("start_time_b > start_time_a & start_time_b < end_time_a")
        .rename(columns={"task_id_a": "task_id"})
    )
    overlap["end"] = np.minimum(overlap.end_time_a, overlap.end_time_b)
    overlap["overlap_duration"] = (
        overlap.end - overlap.start_time_b
    ).dt.total_seconds()

    max_concurrent = (
        (overlap.groupby(["employee_id", "task_id"]).size() + 1)
        .reset_index()
        .groupby("employee_id")[0]
        .max()
        .reindex(EMPS, fill_value=1)
    )
    max_concurrent.name = "max_concurrent_tasks"

    out = (
        pd.concat((tasks.set_index(IDX), overlap.set_index(IDX)), axis=1)
        .fillna(0)
        .groupby("employee_id")
        .apply(
            lambda grp: int(
                (grp.task_duration - grp.overlap_duration).sum() / (60 * 60)
            )
        )
    )
    out.name = "total_task_hours"

    return (
        pd.concat((out, max_concurrent), axis=1)
        .reset_index()
        .sort_values("employee_id")
    )
