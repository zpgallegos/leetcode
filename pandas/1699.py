# https://leetcode.com/problems/number-of-calls-between-two-persons/description/

import pandas as pd


def number_of_calls(calls: pd.DataFrame) -> pd.DataFrame:
    msk = calls.from_id < calls.to_id

    return (
        pd.concat(
            (
                calls[msk].rename(columns={"from_id": "person1", "to_id": "person2"}),
                calls[~msk].rename(columns={"to_id": "person1", "from_id": "person2"}),
            ),
            axis=0,
        )
        .groupby(["person1", "person2"])
        .agg(call_count=("person1", "count"), total_duration=("duration", "sum"))
        .reset_index()
    )
