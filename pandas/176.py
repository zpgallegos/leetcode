# https://leetcode.com/problems/second-highest-salary/solutions/?lang=pythondata

import pandas as pd

data = [[1, 100], [2, 200], [3, 300]]
Employee = pd.DataFrame(data, columns=["id", "salary"]).astype(
    {"id": "int64", "salary": "int64"}
)


def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    s = employee.salary.drop_duplicates()
    if len(s) < 2:
        ans = None
    else:
        ans = s.nlargest(2).iloc[-1]
    return pd.DataFrame({"SecondHighestSalary": [ans]})
