# https://leetcode.com/problems/product-price-at-a-given-date/

import pandas as pd

BEFORE = "2019-08-16"
FILL = 10


def price_at_given_date(products: pd.DataFrame) -> pd.DataFrame:
    sub = products[products.change_date <= BEFORE]
    last = sub[sub.groupby("product_id").change_date.transform(lambda x: x == x.max())]
    
    out = last[["product_id", "new_price"]].rename(columns={"new_price": "price"})
    return (
        out.set_index("product_id")
        .reindex(products.product_id.unique(), fill_value=FILL)
        .reset_index()
    )
