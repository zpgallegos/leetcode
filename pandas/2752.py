# https://leetcode.com/problems/customers-with-maximum-number-of-transactions-on-consecutive-days/description/


import pandas as pd


def find_customers(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions = transactions.sort_values(["customer_id", "transaction_date"])

    transactions["dif"] = (
        transactions.groupby("customer_id").transaction_date.diff(1).dt.days
    )
    transactions["incr"] = transactions.dif.apply(lambda x: pd.isnull(x) or x != 1)
    transactions["grp"] = transactions.incr.cumsum()

    tab = transactions.groupby(["customer_id", "grp"]).size()

    return pd.DataFrame(tab[tab == tab.max()].sort_index().index.get_level_values(0))
