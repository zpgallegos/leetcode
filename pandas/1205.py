# https://leetcode.com/problems/monthly-transactions-ii/

import pandas as pd

data = [
    [101, "US", "approved", 1000, "2019-05-18"],
    [102, "US", "declined", 2000, "2019-05-19"],
    [103, "US", "approved", 3000, "2019-06-10"],
    [104, "US", "declined", 4000, "2019-06-13"],
    [105, "US", "approved", 5000, "2019-06-15"],
]
transactions = pd.DataFrame(
    data, columns=["id", "country", "state", "amount", "trans_date"]
).astype(
    {
        "id": "Int64",
        "country": "object",
        "state": "object",
        "amount": "Int64",
        "trans_date": "datetime64[ns]",
    }
)
data = [[102, "2019-05-29"], [101, "2019-06-30"], [105, "2019-09-18"]]
chargebacks = pd.DataFrame(data, columns=["trans_id", "trans_date"]).astype(
    {"trans_id": "Int64", "trans_date": "datetime64[ns]"}
)


def monthly_transactions(
    transactions: pd.DataFrame, chargebacks: pd.DataFrame
) -> pd.DataFrame:
    for df in (transactions, chargebacks):
        df["month"] = df.trans_date.dt.strftime("%Y-%m")

    chargebacks = chargebacks.merge(
        transactions.drop("month", axis=1), left_on="trans_id", right_on="id"
    )

    grp = ["month", "country"]

    app = (
        transactions.query("state == 'approved'")
        .groupby(grp)
        .agg(approved_count=("id", "size"), approved_amount=("amount", "sum"))
    )
    
    chg = chargebacks.groupby(grp).agg(
        chargeback_count=("id", "size"), chargeback_amount=("amount", "sum")
    )

    return pd.concat((app, chg), axis=1).fillna(0).reset_index()
