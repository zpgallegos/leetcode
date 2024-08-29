# https://leetcode.com/problems/all-people-report-to-the-given-manager/description/

import pandas as pd


def find_reporting_people(employees: pd.DataFrame) -> pd.DataFrame:

    def get_reporting_to(ids: set) -> set:
        out = set()
        reps = set(employees[employees.manager_id.isin(ids)].employee_id) - ids
        out.update(reps)
        if reps:
            out.update(get_reporting_to(reps))  # recurse
        return out

    return pd.DataFrame({"employee_id": list(get_reporting_to(set([1])))})
