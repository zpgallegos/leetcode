# https://leetcode.com/problems/find-category-recommendation-pairs/

import pandas as pd

product_purchases_data = [
    [1, 101, 2],
    [1, 102, 1],
    [1, 201, 3],
    [1, 301, 1],
    [2, 101, 1],
    [2, 102, 2],
    [2, 103, 1],
    [2, 201, 5],
    [3, 101, 2],
    [3, 103, 1],
    [3, 301, 4],
    [3, 401, 2],
    [4, 101, 1],
    [4, 201, 3],
    [4, 301, 1],
    [4, 401, 2],
    [5, 102, 2],
    [5, 103, 1],
    [5, 201, 2],
    [5, 202, 3],
]
product_purchases = pd.DataFrame(
    product_purchases_data,
    columns=["user_id", "product_id", "quantity"],
).astype(
    {
        "user_id": "int64",
        "product_id": "int64",
        "quantity": "int64",
    }
)
product_info_data = [
    [101, "Electronics", 100],
    [102, "Books", 20],
    [103, "Books", 35],
    [201, "Clothing", 45],
    [202, "Clothing", 60],
    [301, "Sports", 75],
    [401, "Kitchen", 50],
]
product_info = pd.DataFrame(
    product_info_data,
    columns=["product_id", "category", "price"],
).astype(
    {
        "product_id": "int64",
        "category": "string",
        "price": "float64",
    }
)


def find_category_recommendation_pairs(
    product_purchases: pd.DataFrame, product_info: pd.DataFrame
) -> pd.DataFrame:

    cats = (
        product_purchases[["user_id", "product_id"]]
        .merge(product_info[["product_id", "category"]], on="product_id")
        .drop_duplicates(subset=["user_id", "category"])
    )

    return (
        cats.merge(cats, on="user_id", suffixes=("1", "2"))
        .query("category1 < category2")
        .groupby(["category1", "category2"], as_index=False)
        .agg(customer_count=("user_id", "size"))
        .query("customer_count >= 3")
        .sort_values(
            ["customer_count", "category1", "category2"], ascending=[False, True, True]
        )
    )
