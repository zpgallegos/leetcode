# https://leetcode.com/problems/seasonal-sales-analysis/


import pandas as pd


def to_season(month: int) -> str:
    if month in (1, 2, 12):
        return "Winter"
    if month in (3, 4, 5):
        return "Spring"
    if month in (6, 7, 8):
        return "Summer"
    return "Fall"


def seasonal_sales_analysis(
    products: pd.DataFrame, sales: pd.DataFrame
) -> pd.DataFrame:

    sales["season"] = sales.sale_date.dt.month.apply(to_season)
    sales["revenue"] = sales.quantity * sales.price

    return (
        sales.merge(products, on="product_id")
        .groupby(["season", "category"], as_index=False)
        .agg(total_quantity=("quantity", "sum"), total_revenue=("revenue", "sum"))
        .sort_values(
            ["season", "total_quantity", "total_revenue"],
            ascending=[True, False, False],
        )
        .drop_duplicates("season", keep="first")
        .sort_values("season")
    )
