import pandas as pd


def find_employees(employees: pd.DataFrame) -> pd.DataFrame:
    tbl = employees[employees.manager_id.notna()].query("salary < 30000")
    
    tbl = tbl.merge(
        employees,
        how="left",
        left_on="manager_id",
        right_on="employee_id",
        suffixes=["_x", "_y"],
    ).rename(columns={"employee_id_x": "employee_id"})

    return tbl.loc[tbl.employee_id_y.isna(), ["employee_id"]].sort_values("employee_id")
