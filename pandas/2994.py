# https://leetcode.com/problems/friday-purchases-ii/description/


import pandas as pd

from datetime import datetime


def friday_purchases(purchases: pd.DataFrame) -> pd.DataFrame:
    FRIS = map(
        lambda x: datetime.strptime(x, "%Y-%m-%d"),
        ["2023-11-03", "2023-11-10", "2023-11-17", "2023-11-24"],
    )
    CAT = pd.api.types.CategoricalDtype(FRIS, ordered=True)

    # cast as categorical so fridays absent from the data will show in agg as zero
    # could do this with a reindex also
    purchases["purchase_date"] = purchases.purchase_date.astype(CAT)

    tbl = (
        purchases.groupby("purchase_date")
        .amount_spend.agg(total_amount=sum)
        .reset_index()
    )
    tbl.insert(0, "week_of_month", range(1, 5))

    # leetcode interpreter is casting to integer...
    tbl["purchase_date"] = pd.to_datetime(tbl.purchase_date)

    return tbl
