# https://leetcode.com/problems/managers-with-at-least-5-direct-reports/?lang=pythondata?envType=daily-question&envId=2023-09-01

import pandas as pd

def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    cnt = employee[employee.managerId.notnull()].managerId.value_counts()
    keep = set(cnt[cnt >= 5].index)
    return employee.loc[employee.id.isin(keep), ["name"]]