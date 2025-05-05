# https://leetcode.com/problems/find-products-with-valid-serial-numbers/description/

import pandas as pd


def find_valid_serial_products(products: pd.DataFrame) -> pd.DataFrame:
    return products[products.description.str.contains(r"\bSN\d{4}-\d{4}\b")].sort_values(
        "product_id"
    )
