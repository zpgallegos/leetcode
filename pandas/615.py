# https://leetcode.com/problems/average-salary-departments-vs-company/


import pandas as pd


def average_salary(salary: pd.DataFrame, employee: pd.DataFrame) -> pd.DataFrame:
    salary["pay_month"] = salary.pay_date.dt.strftime("%Y-%m")
    salary = salary.merge(employee, on="employee_id")

    dep = salary.groupby(["pay_month", "department_id"]).amount.mean().rename("dep_avg")
    mo = salary.groupby("pay_month").amount.mean().rename("mo_avg")

    tbl = dep.reset_index().merge(mo.reset_index(), on="pay_month")
    tbl["comparison"] = tbl.apply(
        lambda row: (
            "higher"
            if row.dep_avg > row.mo_avg
            else "same" if row.dep_avg == row.mo_avg else "lower"
        ),
        axis=1,
    )

    return tbl.drop(columns=["dep_avg", "mo_avg"])
