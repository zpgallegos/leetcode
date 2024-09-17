# https://leetcode.com/problems/calculate-product-final-price/


import pandas as pd


def calculate_final_prices(
    products: pd.DataFrame, discounts: pd.DataFrame
) -> pd.DataFrame:
    discounts = discounts.set_index("category").discount.to_dict()
    products["final_price"] = products.apply(
        lambda row: row.price * (1 - discounts.get(row.category, 0) / 100), axis=1
    )

    return products[["product_id", "final_price", "category"]].sort_values("product_id")
