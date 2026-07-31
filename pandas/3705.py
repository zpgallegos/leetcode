# https://leetcode.com/problems/find-golden-hour-customers/


import pandas as pd


def find_golden_hour_customers(restaurant_orders: pd.DataFrame) -> pd.DataFrame:

    order_time = pd.to_datetime(restaurant_orders["order_timestamp"]).dt.time
    is_peak_order = order_time.between(
        pd.Timestamp("11:00").time(), pd.Timestamp("14:00").time()
    ) | order_time.between(pd.Timestamp("18:00").time(), pd.Timestamp("21:00").time())

    stats = (
        restaurant_orders.assign(is_peak_order=is_peak_order)
        .groupby("customer_id", as_index=False)
        .agg(
            total_orders=("order_id", "nunique"),
            peak_orders=("is_peak_order", "sum"),
            rated_orders=("order_rating", "count"),
            average_rating=("order_rating", "mean"),
        )
    )

    qual = (
        stats["total_orders"].ge(3)
        & stats["average_rating"].ge(4)
        & stats["peak_orders"].div(stats["total_orders"]).ge(0.6)
        & stats["rated_orders"].div(stats["total_orders"]).ge(0.5)
    )

    return (
        stats.loc[qual]
        .assign(
            peak_hour_percentage=lambda df: df["peak_orders"]
            .div(df.total_orders)
            .round(2)
            .mul(100),
            average_rating=lambda df: df["average_rating"].round(2),
        )
        .sort_values(
            ["average_rating", "customer_id"],
            ascending=[False, False],
        )[["customer_id", "total_orders", "peak_hour_percentage", "average_rating"]]
    )
