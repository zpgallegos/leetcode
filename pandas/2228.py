# https://leetcode.com/problems/users-with-two-purchases-within-seven-days/description/

import pandas as pd


def find_valid_users(purchases: pd.DataFrame) -> pd.DataFrame:
    purchases = purchases.sort_values(["user_id", "purchase_date"])
    diff = purchases.groupby("user_id").purchase_date.diff(1).dt.days
    return purchases.loc[diff <= 7, ["user_id"]].drop_duplicates()
