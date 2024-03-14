# https://leetcode.com/problems/sort-the-olympic-table/description/

import pandas as pd


def sort_table(olympic: pd.DataFrame) -> pd.DataFrame:
    return olympic.sort_values(
        ["gold_medals", "silver_medals", "bronze_medals", "country"],
        ascending=[False, False, False, True],
    )
