# https://leetcode.com/problems/find-product-recommendation-pairs/


import pandas as pd


def find_product_recommendation_pairs(
    product_purchases: pd.DataFrame, product_info: pd.DataFrame
) -> pd.DataFrame:
    d = product_purchases.merge(product_info, on="product_id")
    del product_purchases
    del product_info

    return (
        d.merge(d, on="user_id", suffixes=["_x", "_y"])
        .query("product_id_x < product_id_y")
        .groupby(["product_id_x", "product_id_y", "category_x", "category_y"])
        .size()
        .rename("customer_count")
        .reset_index()
        .query("customer_count >= 3")
        .rename(
            columns={
                "product_id_x": "product1_id",
                "product_id_y": "product2_id",
                "category_x": "product1_category",
                "category_y": "product2_category",
            }
        )
        .sort_values(
            ["customer_count", "product1_id", "product2_id"],
            ascending=[False, True, True],
        )
    )
