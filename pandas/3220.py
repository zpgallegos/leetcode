# https://leetcode.com/problems/odd-and-even-transactions/

import pandas as pd


def sum_daily_odd_even(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions["is_even"] = transactions.amount % 2 == 0

    return (
        transactions.groupby(["transaction_date", "is_even"])
        .amount.sum()
        .reset_index()
        .pivot(index="transaction_date", columns="is_even", values="amount")
        .fillna(0)
        .reset_index()
        .rename(columns={True: "even_sum", False: "odd_sum"})[
            ["transaction_date", "odd_sum", "even_sum"]
        ]
    )
