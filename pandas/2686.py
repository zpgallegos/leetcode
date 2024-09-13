# https://leetcode.com/problems/immediate-food-delivery-iii/

import pandas as pd


def immediate_delivery(delivery: pd.DataFrame) -> pd.DataFrame:
    delivery["is_immediate"] = (
        delivery.order_date == delivery.customer_pref_delivery_date
    ).astype(int)

    return (
        delivery.groupby("order_date")
        .is_immediate.apply(lambda x: (x.mean()) * 100)
        .round(2)
        .rename("immediate_percentage")
        .sort_index()
        .reset_index()
    )
