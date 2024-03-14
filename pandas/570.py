# https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

import pandas as pd


def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    cnt = employee[employee.managerId.notnull()].managerId.value_counts()
    keep = set(cnt[cnt >= 5].index)
    return employee.loc[employee.id.isin(keep), ["name"]]


def find_managers(employee: pd.DataFrame) -> pd.DataFrame:
    employee = employee.set_index("id")
    vc = employee.managerId.value_counts()
    return employee.loc[vc[vc >= 5].index, ["name"]]
