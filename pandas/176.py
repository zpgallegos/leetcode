# https://leetcode.com/problems/second-highest-salary/solutions/?lang=pythondata

import pandas as pd


def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    s = employee.salary.drop_duplicates()
    out = s.nlargest(2).iloc[-1] if len(s) >= 2 else None
    return pd.DataFrame({"SecondHighestSalary": [out]})


def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    # slower
    employee["rnk"] = employee.salary.rank(ascending=False, method="dense").astype(int)
    sub = employee[employee.rnk == 2]
    out = sub.iloc[0].salary if not sub.empty else None
    return pd.DataFrame({"SecondHighestSalary": [out]})