# https://leetcode.com/problems/average-time-of-process-per-machine/description/

import pandas as pd


def get_average_time(activity: pd.DataFrame) -> pd.DataFrame:
    return (
        activity.pivot_table(
            index=["machine_id", "process_id"],
            columns="activity_type",
            values="timestamp",
        )
        .apply(lambda row: row.end - row.start, axis=1)
        .rename("processing_time")
        .reset_index()
        .groupby("machine_id")
        .processing_time.mean()
        .round(3)
        .reset_index()
    )
