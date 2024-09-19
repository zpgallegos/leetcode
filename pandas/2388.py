# https://leetcode.com/problems/change-null-values-in-a-table-to-the-previous-value/description/

import pandas as pd


def change_null_values(coffee_shop: pd.DataFrame) -> pd.DataFrame:
    for i, row in enumerate(coffee_shop.itertuples()):
        if not i:
            curr = row.drink
            continue

        if pd.isnull(row.drink):
            coffee_shop.loc[row.Index, "drink"] = curr
        else:
            curr = row.drink

    return coffee_shop


# https://leetcode.com/problems/change-null-values-in-a-table-to-the-previous-value/


import pandas as pd


def change_null_values(coffee_shop: pd.DataFrame) -> pd.DataFrame:
    out = []

    for i, drink in enumerate(coffee_shop.drink):
        if not i:
            curr = drink
        else:
            if pd.notnull(drink):
                curr = drink
        out.append(curr)

    coffee_shop["drink"] = out

    return coffee_shop


def change_null_values(coffee_shop: pd.DataFrame) -> pd.DataFrame:
    """this is probably worse? sql-esque"""

    coffee_shop["grp"] = coffee_shop.drink.notnull().astype(int).cumsum()

    coffee_shop["drink"] = coffee_shop.groupby("grp").drink.transform(
        lambda x: x.iloc[0]
    )

    return coffee_shop.drop("grp", axis=1)
