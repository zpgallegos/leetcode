# https://leetcode.com/problems/find-longest-calls/


import pandas as pd


def format_time(s: int) -> str:
    hours = s // 3600
    minutes = (s % 3600) // 60
    seconds = s % 60
    return f"{hours:02}:{minutes:02}:{seconds:02}"


def find_longest_calls(contacts: pd.DataFrame, calls: pd.DataFrame) -> pd.DataFrame:
    TOP = 3

    calls["rn"] = calls.groupby("type").duration.rank(method="first", ascending=False)

    out = calls[calls.rn <= TOP].merge(contacts, left_on="contact_id", right_on="id")
    out["duration_formatted"] = out.duration.apply(format_time)

    return out.sort_values(
        ["type", "duration", "first_name"], ascending=[True, False, False]
    )[["first_name", "type", "duration_formatted"]]
