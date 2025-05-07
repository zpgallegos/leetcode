# https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/

import pandas as pd


def find_customers(visits: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    has_trans = set(transactions.visit_id)

    return (
        visits[~visits.visit_id.isin(has_trans)]
        .customer_id.value_counts()
        .rename("count_no_trans")
        .reset_index()
    )
