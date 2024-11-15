# https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/

import pandas as pd


def find_subtasks(tasks: pd.DataFrame, executed: pd.DataFrame) -> pd.DataFrame:
    ran = set(executed.itertuples(index=False, name=None))

    out = []
    for row in tasks.itertuples():
        for i in range(1, row.subtasks_count + 1):
            if (row.task_id, i) not in ran:
                out.append({"task_id": row.task_id, "subtask_id": i})

    return pd.DataFrame(out)


def find_subtasks(tasks: pd.DataFrame, executed: pd.DataFrame) -> pd.DataFrame:
    tups = []
    for _, row in tasks.iterrows():
        tups += [(row.task_id, i) for i in range(1, row.subtasks_count + 1)]

    mdx = pd.MultiIndex.from_tuples(tups, names=executed.columns).drop(
        pd.MultiIndex.from_frame(executed)
    )

    return pd.DataFrame(index=mdx).reset_index()
