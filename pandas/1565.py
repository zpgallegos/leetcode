# https://leetcode.com/problems/unique-orders-and-customers-per-month/description/

import pandas as pd


def unique_orders_and_customers(orders: pd.DataFrame) -> pd.DataFrame:
    orders["month"] = orders.order_date.dt.strftime("%Y-%m")

    return (
        orders.query("invoice > 20")
        .groupby("month")
        .agg(order_count=("order_id", len), customer_count=("customer_id", "nunique"))
        .reset_index()
    )
