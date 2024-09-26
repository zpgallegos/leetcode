# https://leetcode.com/problems/dynamic-pivoting-of-a-table/description/

import pandas as pd


def dynamic_pivoting_table(products: pd.DataFrame) -> pd.DataFrame:
    out = products.pivot_table(index="product_id", columns="store", values="price")
    return out[sorted(out.columns)].reset_index()
