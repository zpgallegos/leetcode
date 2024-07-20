# https://leetcode.com/problems/year-on-year-growth-rate/description/


import pandas as pd


data = [
    [1341, 123424, 1500.6, "2019-12-31 12:00:00"],
    [1423, 123424, 1000.2, "2020-12-31 12:00:00"],
    [1623, 123424, 1246.44, "2021-12-31 12:00:00"],
    [1322, 123424, 2145.32, "2022-12-31 12:00:00"],
]
user_transactions = pd.DataFrame(
    data,
    columns=["transaction_id", "product_id", "spend", "transaction_date"],
)
user_transactions["transaction_date"] = pd.to_datetime(
    user_transactions["transaction_date"]
)


def calculate_yoy_growth(user_transactions: pd.DataFrame) -> pd.DataFrame:
    user_transactions["transaction_date"] = pd.to_datetime(
        user_transactions["transaction_date"]
    )
    user_transactions["year"] = user_transactions.transaction_date.dt.year

    tbl = (
        user_transactions.groupby(["product_id", "year"])
        .spend.sum()
        .sort_index()
        .reset_index()
        .rename(columns={"spend": "curr_year_spend"})
    )
    tbl["prev_year_spend"] = tbl.groupby("product_id").curr_year_spend.shift(1)
    tbl["yoy_rate"] = (
        ((tbl.curr_year_spend - tbl.prev_year_spend) * 100) / tbl.prev_year_spend
    ).round(2)

    return tbl[["year", "product_id", "curr_year_spend", "prev_year_spend", "yoy_rate"]]
