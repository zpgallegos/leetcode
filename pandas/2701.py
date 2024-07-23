# https://leetcode.com/problems/consecutive-transactions-with-increasing-amounts/


import pandas as pd


def consecutive_increasing_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    d = transactions.sort_values(["customer_id", "transaction_date"])

    grp = d.groupby("customer_id")
    d["not_consecutive"] = grp.transaction_date.diff(1).dt.days.apply(
        lambda x: pd.isnull(x) or x > 1
    )
    d["not_increasing"] = grp.amount.diff(1).apply(lambda x: pd.isnull(x) or x <= 0)
    d["grp"] = (d.not_consecutive | d.not_increasing).cumsum()

    vc = d.grp.value_counts()
    qual = set(vc[vc >= 3].index)

    return (
        d[d.grp.isin(qual)]
        .groupby(["customer_id", "grp"])
        .agg(
            consecutive_start=("transaction_date", "min"),
            consecutive_end=("transaction_date", "max"),
        )
        .reset_index()
        .drop("grp", axis=1)
    )
