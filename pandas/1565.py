# https://leetcode.com/problems/unique-orders-and-customers-per-month/description/

import pandas as pd


def unique_orders_and_customers(orders: pd.DataFrame) -> pd.DataFrame:
    orders["month"] = orders.order_date.dt.strftime("%Y-%m")

    nunique = lambda x: len(set(x))

    return (
        orders[orders.invoice > 20]
        .groupby("month")
        .agg(order_count=("order_id", nunique), customer_count=("customer_id", nunique))
        .reset_index()
    )
