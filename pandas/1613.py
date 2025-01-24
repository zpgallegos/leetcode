# https://leetcode.com/problems/find-the-missing-ids/description/

import pandas as pd


def find_missing_ids(customers: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame(
        {
            "ids": list(
                set(range(1, customers.customer_id.max() + 1))
                - set(customers.customer_id)
            )
        }
    ).sort_values("ids")

