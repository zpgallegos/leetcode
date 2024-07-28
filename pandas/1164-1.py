# https://leetcode.com/problems/product-price-at-a-given-date/

import pandas as pd

BEFORE = "2019-08-16"
FILL_VAL = 10


def price_at_given_date(products: pd.DataFrame) -> pd.DataFrame:
    sub = products[products.change_date <= BEFORE]

    return (
        sub.set_index(["product_id", "change_date"])
        .loc[
            pd.MultiIndex.from_frame(
                sub.groupby("product_id").change_date.max().reset_index()
            )
        ]
        .droplevel(1)
        .reindex(products.product_id.unique())
        .fillna(FILL_VAL)
        .reset_index()
        .rename(columns={"new_price": "price"})
    )
