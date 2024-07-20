# https://leetcode.com/problems/total-sales-amount-by-year/

import pandas as pd


def total_sales(product: pd.DataFrame, sales: pd.DataFrame) -> pd.DataFrame:

    d = pd.concat(
        [
            pd.DataFrame(
                {
                    "product_id": row.product_id,
                    "date": pd.date_range(row.period_start, row.period_end),
                    "amt": row.average_daily_sales,
                }
            )
            for row in sales.itertuples()
        ],
        axis=0,
    )
    d["report_year"] = d.date.dt.year.astype(str)

    return (
        d.groupby(["product_id", "report_year"])
        .amt.sum()
        .reset_index()
        .merge(product, on="product_id")
        .rename(columns={"amt": "total_amount"})[
            ["product_id", "product_name", "report_year", "total_amount"]
        ]
    )
