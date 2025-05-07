# https://leetcode.com/problems/the-most-frequently-ordered-products-for-each-customer/description/

import pandas as pd


def most_frequently_products(
    customers: pd.DataFrame, orders: pd.DataFrame, products: pd.DataFrame
) -> pd.DataFrame:
    agg = (
        orders.groupby(["customer_id", "product_id"]).size().rename("cnt").reset_index()
    )

    return agg[
        agg.groupby("customer_id").cnt.rank(ascending=False, method="min") == 1
    ].merge(products, on="product_id")[["customer_id", "product_id", "product_name"]]
