# https://leetcode.com/problems/find-customers-with-positive-revenue-this-year/description/


import pandas as pd


def find_customers(customers: pd.DataFrame) -> pd.DataFrame:
    agg = customers.query("year == 2021").groupby("customer_id").revenue.sum()
    return pd.DataFrame(agg[agg > 0].index)
