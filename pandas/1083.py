# https://leetcode.com/problems/sales-analysis-ii/

import pandas as pd


def sales_analysis(product: pd.DataFrame, sales: pd.DataFrame) -> pd.DataFrame:
    d = product.merge(sales, on="product_id")
    iphone = set(d[d.product_name == "iPhone"].buyer_id)

    return d[(d.product_name == "S8") & (~d.buyer_id.isin(iphone))][
        ["buyer_id"]
    ].drop_duplicates()
