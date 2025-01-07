# https://leetcode.com/problems/find-products-with-three-consecutive-digits/


import pandas as pd


def find_products(products: pd.DataFrame) -> pd.DataFrame:
    mask = products.name.str.contains(r"(^|[^\d])\d{3}($|[^\d])")
    return products[mask].sort_values("product_id")
