# https://leetcode.com/problems/find-stores-with-inventory-imbalance/description/

import pandas as pd


def find_inventory_imbalance(
    stores: pd.DataFrame, inventory: pd.DataFrame
) -> pd.DataFrame:

    product_counts = inventory.store_id.value_counts()
    sub = inventory[
        inventory.store_id.isin(product_counts[product_counts >= 3].index)
    ].sort_values(["store_id", "price"])

    grpd = sub.groupby("store_id")
    cheap = grpd.head(1).rename(
        columns={"product_name": "cheapest_product", "quantity": "cheapest_quantity"}
    )
    exp = grpd.tail(1).rename(
        columns={"product_name": "most_exp_product", "quantity": "most_exp_quantity"}
    )

    return (
        cheap.merge(exp, on="store_id")
        .query("most_exp_quantity < cheapest_quantity")
        .assign(
            imbalance_ratio=lambda df: (
                df.cheapest_quantity / df.most_exp_quantity
            ).round(2)
        )
        .merge(stores, on="store_id")
        .sort_values(["imbalance_ratio", "store_name"], ascending=[False, True])[
            [
                "store_id",
                "store_name",
                "location",
                "most_exp_product",
                "cheapest_product",
                "imbalance_ratio",
            ]
        ]
    )


# alternative, using idxmin/idxmax, avoids full sort


def find_inventory_imbalance(
    stores: pd.DataFrame, inventory: pd.DataFrame
) -> pd.DataFrame:

    product_counts = inventory.groupby("store_id")["product_name"].nunique()

    qualified = inventory[
        inventory.store_id.isin(product_counts[product_counts.ge(3)].index)
    ]

    prices = qualified.groupby("store_id", sort=False)["price"]

    cheapest = qualified.loc[
        prices.idxmin(), ["store_id", "product_name", "quantity"]
    ].rename(
        columns={"product_name": "cheapest_product", "quantity": "cheapest_quantity"}
    )

    most_expensive = qualified.loc[
        prices.idxmax(), ["store_id", "product_name", "quantity"]
    ].rename(
        columns={"product_name": "most_exp_product", "quantity": "most_exp_quantity"}
    )

    return (
        cheapest.merge(most_expensive, on="store_id")
        .query("most_exp_quantity < cheapest_quantity")
        .assign(
            imbalance_ratio=lambda df: df.cheapest_quantity.div(
                df.most_exp_quantity
            ).round(2)
        )
        .merge(stores, on="store_id")
        .sort_values(
            ["imbalance_ratio", "store_name"],
            ascending=[False, True],
        )[
            [
                "store_id",
                "store_name",
                "location",
                "most_exp_product",
                "cheapest_product",
                "imbalance_ratio",
            ]
        ]
        .reset_index(drop=True)
    )
