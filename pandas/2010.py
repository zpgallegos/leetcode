# https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company-ii/

import pandas as pd


def number_of_joiners(candidates: pd.DataFrame) -> pd.DataFrame:
    out = []
    budget = 70000

    hired = []
    for exp in ("Senior", "Junior"):

        for row in (
            candidates.loc[candidates.experience == exp]
            .sort_values("salary")
            .itertuples()
        ):
            if row.salary <= budget:
                budget -= row.salary
                hired.append(row.employee_id)
            else:
                break

        out.append({"experience": exp, "accepted_candidates": hired})

    return pd.DataFrame({"employee_id": hired})
