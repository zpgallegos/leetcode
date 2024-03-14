# https://leetcode.com/problems/product-sales-analysis-v/description/

import pandas as pd


def product_sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    return (
        sales.merge(product, on="product_id")
        .groupby("user_id")
        .apply(lambda grp: (grp.quantity * grp.price).sum())
        .reset_index()
        .rename(columns={0: "spending"})
        .sort_values(["spending", "user_id"], ascending=[False, True])
    )
