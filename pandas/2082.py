import pandas as pd

data = [[6, 1, 549], [8, 1, 834], [4, 2, 394], [11, 3, 657], [13, 3, 257]]
Store = pd.DataFrame(data, columns=["bill_id", "customer_id", "amount"]).astype(
    {"bill_id": "int64", "customer_id": "int64", "amount": "int64"}
)


def count_rich_customers(store: pd.DataFrame) -> pd.DataFrame:
    cnt = store.query("amount > 500").customer_id.nunique()
    return pd.DataFrame({"rich_count": cnt}, index=[0])
