# https://leetcode.com/problems/fix-product-name-format/description/

import pandas as pd


def fix_name_format(sales: pd.DataFrame) -> pd.DataFrame:
    sales["product_name"] = sales.product_name.str.strip().str.lower()
    sales["sale_date"] = sales.sale_date.dt.strftime("%Y-%m")

    cols = ["product_name", "sale_date"]
    return (
        sales.groupby(cols)
        .size()
        .reset_index()
        .rename(columns={0: "total"})
        .sort_values(cols)
    )
