# https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company-ii/description/


import pandas as pd


def number_of_joiners(candidates: pd.DataFrame) -> pd.DataFrame:
    out = []
    budget = 70000

    for exp in ["Senior", "Junior"]:
        grp = candidates.loc[candidates.experience == exp].sort_values("salary")
        for row in grp.itertuples():
            if row.salary <= budget:
                out.append(row.employee_id)
                budget -= row.salary
            else:
                break

    return pd.DataFrame({"employee_id": out})
