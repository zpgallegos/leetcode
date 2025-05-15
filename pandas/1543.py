# https://leetcode.com/problems/fix-product-name-format/description/


import pandas as pd


def fix_name_format(sales: pd.DataFrame) -> pd.DataFrame:
    sales["product_name"] = sales.product_name.str.lower().str.strip()
    sales["sale_date"] = sales.sale_date.dt.strftime("%Y-%m")

    return (
        sales.groupby(["product_name", "sale_date"])
        .size()
        .rename("total")
        .sort_index()
        .reset_index()
    )
