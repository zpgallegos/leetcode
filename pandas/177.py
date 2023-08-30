# https://leetcode.com/problems/nth-highest-salary/?lang=pythondata


import pandas as pd


def nth_highest_salary(employee: pd.DataFrame, N: int) -> pd.DataFrame:
    s = employee.salary.drop_duplicates().nlargest(N)
    if len(s) < N:
        val = None
    else:
        val = s.nlargest(N).iloc[-1]
    return pd.DataFrame({f"getNthHighestSalary({N})": [val]})