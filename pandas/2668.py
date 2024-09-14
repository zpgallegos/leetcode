# https://leetcode.com/problems/find-latest-salaries/description/


import pandas as pd


def find_latest_salaries(salary: pd.DataFrame) -> pd.DataFrame:
    return salary.loc[salary.groupby("emp_id").salary.idxmax()].sort_values("emp_id")
