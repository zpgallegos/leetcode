# https://leetcode.com/problems/customer-purchasing-behavior-analysis/description/

import pandas as pd

# convert above to pandas dataframe
transactions = pd.DataFrame(
    [
        (1, 1, 2, "2022-11-17", 702.6),
        (2, 1, 6, "2023-10-27", 434.38),
        (3, 1, 2, "2020-02-08", 922.96),
        (4, 1, 9, "2021-04-02", 136.43),
        (5, 2, 8, "2020-08-18", 677.82),
        (6, 2, 3, "2023-01-09", 346.91),
        (7, 2, 9, "2020-11-30", 977.35),
        (8, 2, 1, "2023-02-10", 212.65),
        (9, 2, 2, "2022-03-31", 627.07),
        (10, 2, 8, "2022-09-03", 628.83),
        (11, 2, 9, "2020-03-03", 658.69),
        (12, 3, 4, "2023-09-21", 298.49),
        (13, 3, 6, "2023-11-14", 416.31),
        (14, 4, 2, "2021-05-31", 273.22),
        (15, 4, 6, "2022-01-30", 535.78),
        (16, 4, 9, "2021-01-02", 76.74),
        (17, 4, 7, "2020-03-07", 543.05),
        (18, 4, 4, "2023-10-15", 455.88),
        (19, 5, 4, "2023-05-28", 147.48),
        (20, 5, 9, "2021-03-27", 219.15),
        (21, 5, 5, "2020-03-16", 461.81),
        (22, 5, 8, "2021-12-05", 621.96),
        (23, 5, 1, "2022-11-18", 486.3),
        (24, 5, 4, "2021-11-26", 317.8),
        (25, 5, 8, "2023-11-28", 960.81),
        (26, 6, 4, "2020-12-09", 491.49),
        (27, 6, 9, "2022-01-15", 222.81),
        (28, 6, 4, "2023-05-27", 56.34),
        (29, 6, 5, "2021-11-30", 220.56),
        (30, 6, 1, "2022-10-23", 88.02),
        (31, 6, 2, "2022-01-09", 998.57),
        (32, 6, 9, "2020-11-13", 72.71),
        (33, 6, 6, "2023-10-01", 840.36),
        (34, 7, 4, "2022-12-15", 527.09),
        (35, 7, 8, "2023-07-08", 386.05),
        (36, 8, 3, "2022-07-08", 326.76),
        (37, 8, 1, "2021-07-23", 363.5),
        (38, 8, 9, "2023-08-04", 711.17),
        (39, 8, 4, "2021-08-06", 544.93),
        (40, 8, 1, "2023-10-31", 53.51),
        (41, 8, 1, "2020-09-26", 580.12),
        (42, 8, 5, "2022-05-10", 181.46),
        (43, 8, 4, "2022-06-10", 498.18),
        (44, 9, 9, "2023-03-13", 643.5),
        (45, 10, 1, "2022-05-05", 459.62),
        (46, 10, 2, "2022-04-08", 799.77),
        (47, 10, 9, "2021-12-12", 981.01),
        (48, 10, 7, "2023-02-27", 202.88),
        (49, 10, 3, "2020-03-04", 807.84),
    ],
    columns=[
        "transaction_id",
        "customer_id",
        "product_id",
        "transaction_date",
        "amount",
    ],
)

products = pd.DataFrame(
    [
        (1, "E", 336.54),
        (2, "B", 197),
        (3, "C", 246.44),
        (4, "D", 348.39),
        (5, "E", 121.55),
        (6, "A", 334.05),
        (7, "B", 489.24),
        (8, "C", 89.51),
        (9, "B", 38.82),
    ],
    columns=["product_id", "category", "price"],
)


def analyze_customer_behavior(
    transactions: pd.DataFrame, products: pd.DataFrame
) -> pd.DataFrame:
    
    transactions["transaction_date"] = pd.to_datetime(transactions["transaction_date"])

    d = transactions.merge(products, on="product_id")
    d["cat_cnt"] = d.groupby(["customer_id", "category"]).customer_id.transform("count")

    fav = (
        d[d.groupby("customer_id").cat_cnt.transform(lambda x: x == x.max())]
        .sort_values(["customer_id", "transaction_date"], ascending=False)
        .groupby("customer_id")
        .first()["category"]
    )

    agg = d.groupby("customer_id").agg(
        total_amount=("amount", "sum"),
        transaction_count=("transaction_id", "nunique"),
        unique_categories=("category", "nunique"),
        avg_transaction_amount=("amount", "mean"),
    )
    agg["top_category"] = fav
    agg["loyalty_score"] = (
        (agg.transaction_count * 10) + (agg.total_amount / 100)
    ).round(2)

    fmt = ["total_amount", "avg_transaction_amount", "loyalty_score"]
    agg[fmt] = agg[fmt].round(2)

    return agg.reset_index().sort_values(
        ["loyalty_score", "customer_id"], ascending=[False, True]
    )
