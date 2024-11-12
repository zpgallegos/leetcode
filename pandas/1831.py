# https://leetcode.com/problems/maximum-transaction-each-day/

import pandas as pd


def find_maximum_transaction(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions["dt"] = transactions.day.dt.date
    mx = transactions.groupby("dt").amount.max().reset_index()
    return transactions.merge(mx, on=["dt", "amount"])[["transaction_id"]].sort_values(
        "transaction_id"
    )
