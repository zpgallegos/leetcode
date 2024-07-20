# https://leetcode.com/problems/find-the-missing-ids/description/

import pandas as pd


def find_missing_ids(customers: pd.DataFrame) -> pd.DataFrame:
    mx = customers.customer_id.max()
    s = set(customers.customer_id)

    return pd.DataFrame(
        {"ids": [i for i in range(1, mx + 1) if i not in s]}
    ).sort_values("ids")
