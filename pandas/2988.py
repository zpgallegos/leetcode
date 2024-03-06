# https://leetcode.com/problems/manager-of-the-largest-department/description/

import pandas as pd


def find_manager(employees: pd.DataFrame) -> pd.DataFrame:
    grp = employees.groupby("dep_id").size()
    grp = grp[grp == grp.max()]

    return (
        employees[
            (employees.dep_id.isin(grp.index)) & (employees.position == "Manager")
        ][["emp_name", "dep_id"]]
        .rename(columns={"emp_name": "manager_name"})
        .sort_values("dep_id")
    )
