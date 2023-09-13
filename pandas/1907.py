# https://leetcode.com/problemset/pandas/

import pandas as pd


def cat(sal):
    if sal < 20000:
        return "Low Salary"
    elif sal <= 50000:
        return "Average Salary"
    return "High Salary"


def count_salary_categories(accounts: pd.DataFrame) -> pd.DataFrame:
    cats = ["Low Salary", "Average Salary", "High Salary"]
    return (
        accounts.income.apply(cat)
        .value_counts()
        .reindex(cats, fill_value=0)
        .reset_index(name="accounts_count")
        .rename(columns={"income": "category"})
    )
