# https://leetcode.com/problems/orders-with-maximum-quantity-above-average/description/


import pandas as pd


def orders_above_average(orders_details: pd.DataFrame) -> pd.DataFrame:
    grp = orders_details.groupby("order_id").agg(
        avg=("quantity", "mean"), mx=("quantity", "max")
    )
    return pd.DataFrame(grp[grp.mx > grp.avg.max()].index)
