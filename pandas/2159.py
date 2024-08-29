# https://leetcode.com/problems/order-two-columns-independently/description/

import pandas as pd


def order_two_columns(data: pd.DataFrame) -> pd.DataFrame:
    return pd.concat(
        (
            data.first_col.sort_values().reset_index(drop=True),
            data.second_col.sort_values(ascending=False).reset_index(drop=True),
        ),
        axis=1,
    )
