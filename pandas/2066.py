# https://leetcode.com/problems/account-balance/description/

import pandas as pd


def account_balance(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions = transactions.sort_values(["account_id", "day"])
    transactions["amt"] = transactions.apply(
        lambda row: (-1 if row.type == "Withdraw" else 1) * row.amount, axis=1
    )
    transactions["balance"] = transactions.groupby("account_id").amt.cumsum()

    return transactions[["account_id", "day", "balance"]]
