# https://leetcode.com/problems/the-most-recent-three-orders/


import pandas as pd


def recent_three_orders(customers: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    orders = orders.sort_values(["customer_id", "order_date"], ascending=[True, False])

    return (
        orders[orders.groupby("customer_id").cumcount() < 3]
        .merge(customers.rename(columns={"name": "customer_name"}), on="customer_id")[
            ["customer_name", "customer_id", "order_id", "order_date"]
        ]
        .sort_values(
            ["customer_name", "customer_id", "order_date"],
            ascending=[True, True, False],
        )
    )
