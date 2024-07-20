# https://leetcode.com/problems/restaurant-growth/

import pandas as pd


def restaurant_growth(customer: pd.DataFrame) -> pd.DataFrame:
    tbl = customer.groupby("visited_on").amount.sum().reset_index()
    roll = tbl.amount.rolling(7)
    tbl["sum_amount"] = roll.sum()
    tbl["average_amount"] = roll.mean().round(2)
    
    return (
        tbl.loc[tbl.average_amount.notnull()]
        .drop("amount", axis=1)
        .rename(columns={"sum_amount": "amount"})
    )
