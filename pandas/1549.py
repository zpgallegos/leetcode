# https://leetcode.com/problems/the-most-recent-orders-for-each-product/description/

import pandas as pd


def most_recent_orders(
    customers: pd.DataFrame, orders: pd.DataFrame, products: pd.DataFrame
) -> pd.DataFrame:
    return (
        orders[
            orders.groupby("product_id").order_date.rank(ascending=False, method="min")
            == 1
        ]
        .merge(products, on="product_id")[
            ["product_name", "product_id", "order_id", "order_date"]
        ]
        .sort_values(["product_name", "product_id", "order_id"])
    )
