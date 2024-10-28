# https://leetcode.com/problems/first-and-last-call-on-the-same-day/

import pandas as pd


def same_day_calls(calls: pd.DataFrame) -> pd.DataFrame:
    calls["day"] = calls.call_time.dt.date

    calls = pd.concat(
        (
            calls,
            calls.rename(
                columns={"caller_id": "recipient_id", "recipient_id": "caller_id"}
            ),
        ),
        axis=0,
    ).sort_values(["caller_id", "call_time"])
    
    grp = calls.groupby(["caller_id", "day"]).recipient_id
    calls["frst"] = grp.transform(lambda x: x.iloc[0])
    calls["lst"] = grp.transform(lambda x: x.iloc[-1])

    return (
        calls.loc[calls.frst == calls.lst, ["caller_id"]]
        .rename(columns={"caller_id": "user_id"})
        .drop_duplicates()
    )
