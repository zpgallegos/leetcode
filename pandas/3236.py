# https://leetcode.com/problems/ceo-subordinate-hierarchy/description/


import pandas as pd


def find_subordinates(employees: pd.DataFrame) -> pd.DataFrame:
    ceo = employees[employees.manager_id.isnull()].copy()
    assert ceo.shape[0] == 1

    rename = {
        "employee_id": "subordinate_id",
        "employee_name": "subordinate_name",
        "salary": "subordinate_salary",
    }

    ceo["salary_difference"] = 0
    ceo = ceo.rename(columns=rename)

    dfs = [ceo]
    level = 1
    while True:
        subs = employees.merge(
            dfs[-1],
            left_on="manager_id",
            right_on="subordinate_id",
            suffixes=["_sub", "_mang"],
        )

        if not subs.shape[0]:
            break

        subs["salary_difference"] = subs.salary_difference + (
            subs.salary - subs.subordinate_salary
        )
        subs["hierarchy_level"] = level
        subs = subs[
            [
                "employee_id",
                "employee_name",
                "hierarchy_level",
                "salary",
                "salary_difference",
            ]
        ].rename(columns=rename)

        dfs.append(subs)
        level += 1

    dfs = dfs[1:]
    out_cols = [
        "subordinate_id",
        "subordinate_name",
        "hierarchy_level",
        "salary_difference",
    ]

    if not dfs:
        # stupid edge testcase with a nonsensical reporting hierarchy, no one reports to the ceo
        return pd.DataFrame([], columns=out_cols)

    return pd.concat(dfs, axis=0)[out_cols].sort_values(
        ["hierarchy_level", "subordinate_id"]
    )
