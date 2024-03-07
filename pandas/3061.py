# https://leetcode.com/problems/calculate-trapping-rain-water/description/


import pandas as pd

data = [
    [1, 0],
    [2, 1],
    [3, 0],
    [4, 2],
    [5, 1],
    [6, 0],
    [7, 1],
    [8, 3],
    [9, 2],
    [10, 1],
    [11, 2],
    [12, 1],
]
heights = pd.DataFrame(data, columns=["id", "height"]).astype(
    {"id": "Int64", "height": "Int64"}
)


def running_max(lst):
    mx = 0
    out = []
    for val in lst:
        out.append(mx)
        if val > mx:
            mx = val
    return out


def calculate_trapped_rain_water(heights: pd.DataFrame) -> pd.DataFrame:
    heights["max_left"] = running_max(heights.height)
    heights["max_right"] = running_max(heights.height[::-1])[::-1]

    out = (
        heights.apply(lambda row: min(row.max_left, row.max_right) - row.height, axis=1)
        .clip(lower=0)
        .sum()
    )

    return pd.DataFrame({"total_trapped_water": [out]})
