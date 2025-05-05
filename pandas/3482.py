# https://leetcode.com/problems/analyze-organization-hierarchy/description/

import pandas as pd


def analyze_organization_hierarchy(employees: pd.DataFrame) -> pd.DataFrame:
    e = employees.drop("department", axis=1).set_index("employee_id")
    del employees

    def append_level(df, curr_mgrs, curr_level):  # recursive
        sub = df.loc[df.manager_id.isin(curr_mgrs)]
        if sub.empty:
            return df
        df.loc[sub.index, "level"] = curr_level + 1
        return append_level(df, set(sub.index), curr_level + 1)

    def build_dep_map(obj, deps, emps):  # recursive
        if not emps:
            return obj

        mgrs = set()
        for emp in emps:
            mgr = deps[emp]
            if not mgr:
                continue
            mgrs.add(mgr)

            obj[mgr].add(emp)
            if mgr in obj:
                obj[mgr].update(obj[emp])

        return build_dep_map(obj, deps, mgrs)

    e["level"] = e.manager_id.isnull().astype(int)
    e = append_level(e, e.query("level == 1").index, 1)

    deps = e.manager_id.to_dict()  # employee_id -> manager_id
    btm = [k for k in deps.keys() if k not in deps.values()]  # no direct reports
    dep_map = build_dep_map({k: set() for k in sorted(deps)}, deps, btm)

    e["team_size"] = e.index.map(lambda idx: len(dep_map[idx]))
    e["budget"] = e.apply(
        lambda row: row.salary + e.loc[list(dep_map[row.name]), "salary"].sum(), axis=1
    )

    return (
        e[["employee_name", "level", "team_size", "budget"]]
        .reset_index()
        .sort_values(
            ["level", "budget", "employee_name"], ascending=[True, False, True]
        )
    )
