# https://leetcode.com/problems/sales-by-day-of-the-week/


import pandas as pd

DAYS = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
]


def sales_by_day(orders: pd.DataFrame, items: pd.DataFrame) -> pd.DataFrame:
    orders["day_name"] = orders.order_date.dt.day_name()

    mdx = pd.MultiIndex.from_product(
        (items.item_category.unique(), DAYS), names=["item_category", "day_name"]
    )

    return (
        orders.merge(items, on="item_id")
        .groupby(["item_category", "day_name"])
        .quantity.sum()
        .rename("category_count")
        .reindex(mdx, fill_value=0)
        .reset_index()
        .pivot(index="item_category", columns="day_name", values="category_count")[DAYS]
        .sort_index()
        .reset_index()
        .rename(columns={"item_category": "Category"})
    )
