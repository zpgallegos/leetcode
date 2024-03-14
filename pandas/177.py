# https://leetcode.com/problems/nth-highest-salary/description/

import pandas as pd


def nth_highest_salary(employee: pd.DataFrame, N: int) -> pd.DataFrame:
    if not N:
        out = None
    else:
        s = employee.salary.drop_duplicates().nlargest(N)
        out = s.iloc[-1] if len(s) == N else None
    return pd.DataFrame({f"getNthHighestSalary({N})": [out]})