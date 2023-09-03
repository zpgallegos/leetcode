# https://leetcode.com/problems/market-analysis-i/?lang=pythondata

import pandas as pd


def market_analysis(
    users: pd.DataFrame, orders: pd.DataFrame, items: pd.DataFrame
) -> pd.DataFrame:
    col = "orders_in_2019"

    order_cnt = (
        orders[orders.order_date.dt.year == 2019]
        .groupby("buyer_id")
        .size()
        .reset_index(name=col)
    )

    out = (
        users[["user_id", "join_date"]]
        .rename(columns={"user_id": "buyer_id"})
        .merge(order_cnt, on="buyer_id", how="left")
    )
    out[col] = out[col].fillna(0)

    return out