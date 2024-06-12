# https://leetcode.com/problems/merge-overlapping-events-in-the-same-hall/

import numpy as np
import pandas as pd


def merge_events(hall_events: pd.DataFrame) -> pd.DataFrame:
    hall_events = hall_events.sort_values(["hall_id", "start_day", "end_day"])

    data = []
    for hall_id, grp in hall_events.groupby("hall_id"):
        for i, (_, row) in enumerate(grp.iterrows()):
            if not i:
                curr_start, curr_end = row.start_day, row.end_day
                continue

            if row.start_day <= curr_end:
                curr_end = max(curr_end, row.end_day)
            else:
                data.append([hall_id, curr_start, curr_end])
                curr_start, curr_end = row.start_day, row.end_day

        data.append([hall_id, curr_start, curr_end])

    return pd.DataFrame(data, columns=["hall_id", "start_day", "end_day"])
