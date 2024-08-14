# https://leetcode.com/problems/drop-type-1-orders-for-customers-with-type-0-orders/description/


import pandas as pd


def drop_specific_orders(orders: pd.DataFrame) -> pd.DataFrame:
    return orders[
        ~(
            (orders.customer_id.isin(set(orders.query("order_type == 0").customer_id)))
            & (orders.order_type == 1)
        )
    ]
