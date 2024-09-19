# https://leetcode.com/problems/calculate-the-influence-of-each-salesperson/

import pandas as pd


def calculate_influence(
    salesperson: pd.DataFrame, customer: pd.DataFrame, sales: pd.DataFrame
) -> pd.DataFrame:
    return salesperson.merge(
        sales.merge(customer, on="customer_id")
        .groupby("salesperson_id")
        .price.sum()
        .rename("total")
        .reset_index(),
        on="salesperson_id",
        how="left",
    ).fillna(0)
