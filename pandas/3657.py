# https://leetcode.com/problems/find-loyal-customers/


import pandas as pd

data = [
    [1, 101, "2024-01-05", 150.0, "purchase"],
    [2, 101, "2024-01-15", 200.0, "purchase"],
    [3, 101, "2024-02-10", 180.0, "purchase"],
    [4, 101, "2024-02-20", 250.0, "purchase"],
    [5, 102, "2024-01-10", 100.0, "purchase"],
    [6, 102, "2024-01-12", 120.0, "purchase"],
    [7, 102, "2024-01-15", 80.0, "refund"],
    [8, 102, "2024-01-18", 90.0, "refund"],
    [9, 102, "2024-02-15", 130.0, "purchase"],
    [10, 103, "2024-01-01", 500.0, "purchase"],
    [11, 103, "2024-01-02", 450.0, "purchase"],
    [12, 103, "2024-01-03", 400.0, "purchase"],
    [13, 104, "2024-01-01", 200.0, "purchase"],
    [14, 104, "2024-02-01", 250.0, "purchase"],
    [15, 104, "2024-02-15", 300.0, "purchase"],
    [16, 104, "2024-03-01", 350.0, "purchase"],
    [17, 104, "2024-03-10", 280.0, "purchase"],
    [18, 104, "2024-03-15", 100.0, "refund"],
]
customer_transactions = pd.DataFrame(
    data,
    columns=[
        "transaction_id",
        "customer_id",
        "transaction_date",
        "amount",
        "transaction_type",
    ],
).astype(
    {
        "transaction_id": "int64",
        "customer_id": "int64",
        "transaction_date": "datetime64[ns]",
        "amount": "float64",
        "transaction_type": "string",
    }
)


def find_loyal_customers(customer_transactions: pd.DataFrame) -> pd.DataFrame:

    customer_transactions = customer_transactions.assign(
        transaction_date=pd.to_datetime(customer_transactions.transaction_date)
    )

    return (
        customer_transactions.groupby("customer_id", as_index=False)
        .agg(
            refund_rate=("transaction_type", lambda s: s.eq("refund").mean()),
            transaction_count=("transaction_type", lambda s: s.eq("purchase").sum()),
            first_transaction=("transaction_date", "min"),
            last_transaction=("transaction_date", "max"),
        )
        .assign(tenure=lambda df: (df.last_transaction - df.first_transaction).dt.days)
        .query("refund_rate < 0.2 and transaction_count >= 3 and tenure >= 30")[
            ["customer_id"]
        ]
    )
