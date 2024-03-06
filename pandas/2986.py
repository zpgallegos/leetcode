# https://leetcode.com/problems/find-third-transaction/

import pandas as pd


def find_third_transaction(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions = transactions.sort_values(["user_id", "transaction_date"])
    grp = transactions.groupby("user_id")

    return (
        transactions[
            (grp.cumcount() == 2) & (grp.spend.diff(1) > 0) & (grp.spend.diff(2) > 0)
        ]
        .sort_values("user_id")
        .rename(
            columns={
                "spend": "third_transaction_spend",
                "transaction_date": "third_transaction_date",
            }
        )
    )
