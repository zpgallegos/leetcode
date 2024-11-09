# https://leetcode.com/problems/count-salary-categories/submissions/1447251928/

import pandas as pd


def count_salary_categories(accounts: pd.DataFrame) -> pd.DataFrame:
    return (
        accounts.rename(columns={"income": "category"})
        .category.apply(
            lambda x: (
                "High Salary"
                if x > 50000
                else "Average Salary" if x >= 20000 else "Low Salary"
            )
        )
        .value_counts()
        .rename("accounts_count")
        .reindex(["High Salary", "Average Salary", "Low Salary"], fill_value=0)
        .reset_index()
    )
