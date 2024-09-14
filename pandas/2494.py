# https://leetcode.com/problems/merge-overlapping-events-in-the-same-hall/

import pandas as pd


def merge_events(hall_events: pd.DataFrame) -> pd.DataFrame:
    hall_events = hall_events.drop_duplicates().sort_values(
        ["hall_id", "start_day", "end_day"]
    )

    data = []
    for hall_id, grp in hall_events.groupby("hall_id"):
        for i, (_, row) in enumerate(grp.iterrows()):
            if not i:
                start, end = row.start_day, row.end_day
                continue

            if row.start_day <= end:
                end = max(end, row.end_day)
            else:
                data.append((hall_id, start, end))
                start, end = row.start_day, row.end_day

        data.append((hall_id, start, end))

    return pd.DataFrame(data, columns=hall_events.columns)
