# https://leetcode.com/problems/calculate-compressed-mean/

import pandas as pd


def compressed_mean(orders: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame(
        {
            "average_items_per_order": [
                (
                    (orders.item_count * orders.order_occurrences).sum()
                    / orders.order_occurrences.sum()
                ).round(2)
            ]
        }
    )
