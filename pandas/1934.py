# https://leetcode.com/problems/confirmation-rate/

import pandas as pd


def confirmation_rate(
    signups: pd.DataFrame, confirmations: pd.DataFrame
) -> pd.DataFrame:
    return (
        confirmations.groupby("user_id")
        .action.apply(lambda x: (x == "confirmed").mean())
        .round(2)
        .rename("confirmation_rate")
        .reindex(signups.user_id.unique(), fill_value=0)
        .reset_index()
    )
