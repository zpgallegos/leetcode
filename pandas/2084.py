# https://leetcode.com/problems/drop-type-1-orders-for-customers-with-type-0-orders/description/


import pandas as pd


def drop_specific_orders(orders: pd.DataFrame) -> pd.DataFrame:
    has_zero = set(orders.query("order_type == 0").customer_id)
    return orders[~((orders.customer_id.isin(has_zero)) & (orders.order_type == 1))]
