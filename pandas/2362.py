# https://leetcode.com/problems/generate-the-invoice/

import pandas as pd


def generate_the_invoice(
    products: pd.DataFrame, purchases: pd.DataFrame
) -> pd.DataFrame:
    d = purchases.merge(products, on="product_id").set_index("invoice_id")
    d["price"] = d.quantity * d.price
    t = d.groupby("invoice_id").price.sum()

    return d.loc[t.idxmax()] # t's index is ordered, min invoice_id is returned in case of tie


# https://leetcode.com/problems/generate-the-invoice/


import pandas as pd


def generate_the_invoice(
    products: pd.DataFrame, purchases: pd.DataFrame
) -> pd.DataFrame:
    tbl = purchases.merge(products, on="product_id")
    tbl["total"] = tbl.quantity * tbl.price

    d = tbl.groupby("invoice_id").total.sum()
    out = d[d == d.max()]

    return (
        tbl[tbl.invoice_id == out.index.min()]
        .drop(["invoice_id", "price"], axis=1)
        .rename(columns={"total": "price"})
    )
