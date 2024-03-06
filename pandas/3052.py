# https://leetcode.com/problems/maximize-items/description/

import numpy as np
import pandas as pd


def maximize_items(inventory: pd.DataFrame) -> pd.DataFrame:
    SPACE = 500000
    CATS = ["prime_eligible", "not_prime"]

    inventory["item_type"] = inventory.item_type.astype(
        pd.api.types.CategoricalDtype(categories=CATS)
    )
    grpd = inventory.groupby("item_type").agg(
        item_count=("item_id", len), space=("square_footage", np.sum)
    )
    P = grpd.loc["prime_eligible"]
    N = grpd.loc["not_prime"]

    prime_mult = int(SPACE / P["space"])
    prime_used = prime_mult * P["space"]
    prime_items = int(prime_mult * P["item_count"])

    np_mult = int((SPACE - prime_used) / N["space"])
    np_items = int(np_mult * N["item_count"])

    return pd.DataFrame(
        {"item_type": CATS, "item_count": [prime_items, np_items]}
    ).sort_values("item_count", ascending=False)
