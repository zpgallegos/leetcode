# https://leetcode.com/problems/warehouse-manager/description/


import pandas as pd


def warehouse_manager(warehouse: pd.DataFrame, products: pd.DataFrame) -> pd.DataFrame:
    return (
        warehouse.merge(products, on="product_id")
        .groupby("name")
        .apply(lambda grp: (grp.units * grp.Width * grp.Length * grp.Height).sum())
        .rename("volume")
        .reset_index()
        .rename(columns={"name": "warehouse_name"})
    )
