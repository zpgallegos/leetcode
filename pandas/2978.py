# https://leetcode.com/problems/symmetric-coordinates/

import pandas as pd


def symmetric_pairs(coordinates: pd.DataFrame) -> pd.DataFrame:
    coordinates = (
        coordinates.sort_values(["X", "Y"])
        .reset_index()
        .rename(columns={"index": "row"})
    )

    coordinates = coordinates.merge(
        coordinates, left_on=["X", "Y"], right_on=["Y", "X"], suffixes=["_x", "_y"]
    )

    return (
        coordinates[
            (coordinates.X_x <= coordinates.Y_x)
            & (coordinates.row_x != coordinates.row_y)
        ]
        .rename(columns={"X_x": "X", "Y_x": "Y"})[["X", "Y"]]
        .drop_duplicates()
    )
