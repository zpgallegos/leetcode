# https://leetcode.com/problems/suspicious-bank-accounts/description/

import pandas as pd


def suspicious_bank_accounts(
    accounts: pd.DataFrame, transactions: pd.DataFrame
) -> pd.DataFrame:
    transactions["month"] = transactions.day.dt.to_period("M").dt.to_timestamp()

    agg = (
        transactions.query("type == 'Creditor'")
        .groupby(["account_id", "month"])
        .amount.sum()
        .reset_index()
        .merge(accounts, on="account_id")
        .query("amount > max_income")
        .set_index(["account_id", "month"])
    )

    out = []
    for acc in agg.index.levels[0]:
        for mnth in agg.loc[acc].index:
            if (acc, mnth + pd.DateOffset(months=1)) in agg.index:
                out.append(acc)
                break

    return pd.DataFrame({"account_id": out})
