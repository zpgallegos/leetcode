# https://leetcode.com/problems/loan-types/submissions/1201954538/

import pandas as pd


def loan_types(loans: pd.DataFrame) -> pd.DataFrame:
    get = lambda loan: set(loans[loans.loan_type == loan].user_id)

    return pd.DataFrame(
        {"user_id": list(get("Mortgage").intersection(get("Refinance")))}
    ).sort_values("user_id")
