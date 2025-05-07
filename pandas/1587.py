# https://leetcode.com/problems/bank-account-summary-ii/description/

import pandas as pd


def account_summary(users: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    return (
        transactions.groupby("account")
        .amount.sum()
        .rename("balance")
        .reset_index()
        .query("balance > 10000")
        .merge(users, on="account")[["name", "balance"]]
    )
