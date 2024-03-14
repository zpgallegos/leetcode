# https://leetcode.com/problems/products-price-for-each-store/submissions/1201141109/


import pandas as pd


def products_price(products: pd.DataFrame) -> pd.DataFrame:
    tbl = products.pivot(index="product_id", columns="store", values="price")
    return tbl[sorted(tbl.columns)].sort_values("product_id").reset_index()
