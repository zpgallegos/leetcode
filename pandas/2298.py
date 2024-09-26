# https://leetcode.com/problems/tasks-count-in-the-weekend/description/

import pandas as pd


def count_tasks(tasks: pd.DataFrame) -> pd.DataFrame:
    return (
        (~tasks.submit_date.dt.weekday.isin([5, 6]))
        .value_counts()
        .reset_index()
        .pivot_table(columns="submit_date", values="count")
        .rename(columns={False: "weekend_cnt", True: "working_cnt"})
    )
