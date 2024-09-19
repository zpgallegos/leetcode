# https://leetcode.com/problems/product-sales-analysis-iv/


import pandas as pd


def product_sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    sales = sales.merge(product, on="product_id")
    sales["spent"] = sales.quantity * sales.price

    tab = sales.groupby(["user_id", "product_id"], as_index=False).spent.sum()
    tab["rnk"] = tab.groupby("user_id").spent.rank(ascending=False, method="min")

    return tab.query("rnk == 1")[["user_id", "product_id"]]
