# https://leetcode.com/problems/friday-purchase-iii/


import pandas as pd


def cat_week(day):
    if day == 3:
        return 1
    if day == 10:
        return 2
    if day == 17:
        return 3
    return 4


def friday_purchases(purchases: pd.DataFrame, users: pd.DataFrame) -> pd.DataFrame:
    USERTYPES = ["VIP", "Premium"]
    MONTHS = list(range(1, 5))
    idx = pd.MultiIndex.from_product(
        [MONTHS, USERTYPES], names=["week_of_month", "membership"]
    )

    fri = purchases[purchases.purchase_date.dt.weekday == 4]
    fri = pd.merge(fri, users, on="user_id")
    fri = fri[fri.membership.isin(USERTYPES)].copy()
    fri["week_of_month"] = fri.purchase_date.dt.day.apply(cat_week)

    return (
        fri.groupby(["week_of_month", "membership"], observed=True)
        .amount_spend.sum()
        .rename("total_amount")
        .reindex(idx, fill_value=0)
        .reset_index()
        .sort_values(["week_of_month", "membership"])
    )
