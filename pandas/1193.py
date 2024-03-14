# https://leetcode.com/problems/monthly-transactions-i/description/

import numpy as np
import pandas as pd


def monthly_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    transactions["month"] = transactions.trans_date.dt.strftime("%Y-%m")
    transactions["app_amt"] = np.where(
        transactions.state == "approved", transactions.amount, 0
    )

    return (
        transactions.groupby(["month", "country"], dropna=False)
        .agg(
            trans_count=("id", len),
            approved_count=("state", lambda x: (x == "approved").sum()),
            trans_total_amount=("amount", np.sum),
            approved_total_amount=("app_amt", np.sum),
        )
        .reset_index()
    )
