# https://leetcode.com/problems/product-sales-analysis-iii/


import pandas as pd


def sales_analysis(sales: pd.DataFrame, product: pd.DataFrame) -> pd.DataFrame:
    first = sales.groupby("product_id").year.min().rename("first_year").reset_index()

    return sales.merge(
        first, left_on=["product_id", "year"], right_on=["product_id", "first_year"]
    )[
        [
            "product_id",
            "first_year",
            "quantity",
            "price",
        ]
    ]
