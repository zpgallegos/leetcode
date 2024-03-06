# https://leetcode.com/problems/friday-purchases-i/description/

import numpy as np
import pandas as pd


def friday_purchases(purchases: pd.DataFrame) -> pd.DataFrame:
    fri = purchases[purchases.purchase_date.dt.weekday == 4].copy()
    fri["week_of_month"] = np.ceil(fri.purchase_date.dt.day / 7)

    return (
        fri.groupby(["week_of_month", "purchase_date"])
        .amount_spend.sum()
        .reset_index()
        .rename(columns={"amount_spend": "total_amount"})
        .sort_values("week_of_month")
    )
