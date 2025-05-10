# https://leetcode.com/problems/bank-account-summary/description/


import pandas as pd


def bank_account_summary(
    users: pd.DataFrame, transactions: pd.DataFrame
) -> pd.DataFrame:
    return (
        pd.concat(
            (
                transactions.rename(columns={"paid_by": "user_id"}).assign(
                    amount=lambda x: -x.amount
                ),
                transactions.rename(columns={"paid_to": "user_id"}),
            ),
            axis=0,
        )
        .groupby("user_id")
        .amount.sum()
        .reindex(users.user_id, fill_value=0)
        .reset_index()
        .merge(users, how="right")
        .assign(
            credit=lambda x: x.credit + x.amount,
            credit_limit_breached=lambda x: (x.credit < 0).apply(
                lambda k: "Yes" if k else "No"
            ),
        )
        .drop("amount", axis=1)
    )
