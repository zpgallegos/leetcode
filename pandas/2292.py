# https://leetcode.com/problems/products-with-three-or-more-orders-in-two-consecutive-years/description/

import pandas as pd


def find_valid_products(orders: pd.DataFrame) -> pd.DataFrame:
    orders["yr"] = orders.purchase_date.dt.year

    tbl = (
        orders.groupby(["product_id", "yr"])
        .size()
        .rename("yr_total")
        .reset_index()
        .query("yr_total >= 3")
    )

    out = []
    for product_id, grp in tbl.groupby("product_id"):
        years = set(grp.yr)
        for year in years:
            if year + 1 in years:
                out.append(product_id)
                break

    return pd.DataFrame({"product_id": out})
