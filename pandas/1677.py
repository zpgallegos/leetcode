# https://leetcode.com/problems/products-worth-over-invoices/description/

import pandas as pd


def analyze_products(product: pd.DataFrame, invoice: pd.DataFrame) -> pd.DataFrame:
    prods = product.name.unique()

    aggd = (
        invoice.merge(product, on="product_id")
        .groupby("name")
        .agg({"rest": "sum", "paid": "sum", "canceled": "sum", "refunded": "sum"})
    )

    return aggd.reindex(prods).fillna(0).reset_index().sort_values("name")
