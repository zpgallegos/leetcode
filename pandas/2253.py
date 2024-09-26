# https://leetcode.com/problems/dynamic-unpivoting-of-a-table/description/

import pandas as pd


def find_valid_users(products: pd.DataFrame) -> pd.DataFrame:
    return (
        products.melt(id_vars="product_id")
        .dropna()
        .rename(columns={"variable": "store", "value": "price"})
    )
