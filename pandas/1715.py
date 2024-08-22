# https://leetcode.com/problems/count-apples-and-oranges/

import pandas as pd


def count_apples_and_oranges(boxes: pd.DataFrame, chests: pd.DataFrame) -> pd.DataFrame:

    d = boxes.merge(chests, on="chest_id", how="left", suffixes=["_x", "_y"])

    return pd.DataFrame(
        {
            "apple_count": [d.apple_count_x.sum() + d.apple_count_y.sum()],
            "orange_count": [d.orange_count_x.sum() + d.orange_count_y.sum()],
        }
    )
