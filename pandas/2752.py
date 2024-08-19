# https://leetcode.com/problems/customers-with-maximum-number-of-transactions-on-consecutive-days/description/


import pandas as pd


def find_customers(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions = transactions.sort_values(["customer_id", "transaction_date"])

    transactions["last_diff"] = (
        transactions.groupby("customer_id").transaction_date.diff(1).dt.days
    )
    transactions["incr"] = transactions.last_diff.apply(lambda x: int(x != 1))
    transactions["grp"] = transactions.incr.cumsum()

    c = transactions.groupby(["customer_id", "grp"]).size()

    return (
        pd.DataFrame(c[c == c.max()].index.get_level_values(0))
        # .drop_duplicates()  # the test cases want you to leave in duplicates...
        .sort_values("customer_id")
    )
