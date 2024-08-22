# https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/

import pandas as pd


def find_subtasks(tasks: pd.DataFrame, executed: pd.DataFrame) -> pd.DataFrame:
    tups = []
    for _, row in tasks.iterrows():
        tups += [(row.task_id, i) for i in range(1, row.subtasks_count + 1)]

    mdx = pd.MultiIndex.from_tuples(tups, names=executed.columns).drop(
        pd.MultiIndex.from_frame(executed)
    )

    return pd.DataFrame(index=mdx).reset_index()
