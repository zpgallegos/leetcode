# https://leetcode.com/problems/customer-order-frequency/description/

import pandas as pd


def customer_order_frequency(
    customers: pd.DataFrame, product: pd.DataFrame, orders: pd.DataFrame
) -> pd.DataFrame:
    orders["month"] = orders.order_date.dt.month

    tab = (
        orders.query("order_date >= '2020-06-01' and order_date <= '2020-07-31'")
        .merge(product, on="product_id")
        .groupby(["customer_id", "month"])
        .apply(lambda grp: (grp.quantity * grp.price).sum() >= 100)
    )

    b = tab.groupby("customer_id").sum() == 2
    incl = set(b[b].index)

    return customers.loc[customers.customer_id.isin(incl), ["customer_id", "name"]]
