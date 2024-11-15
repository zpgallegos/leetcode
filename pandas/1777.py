# https://leetcode.com/problems/products-price-for-each-store/description/

import pandas as pd


def products_price(products: pd.DataFrame) -> pd.DataFrame:
    return products.pivot_table(
        values="price", columns="store", index="product_id"
    ).reset_index()
