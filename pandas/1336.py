# https://leetcode.com/problems/number-of-transactions-per-visit/description/

import pandas as pd


def draw_chart(visits: pd.DataFrame, transactions: pd.DataFrame) -> pd.DataFrame:
    cnts = (
        visits.merge(
            transactions,
            left_on=["user_id", "visit_date"],
            right_on=["user_id", "transaction_date"],
            how="left",
        )
        .groupby(["user_id", "visit_date"])
        .transaction_date.count()
        .value_counts()
    )
    cnts = (
        cnts.reindex(range(0, cnts.index.max() + 1), fill_value=0)
        .sort_index()
        .reset_index()
    )
    cnts.columns = ["transactions_count", "visits_count"]
    return cnts
