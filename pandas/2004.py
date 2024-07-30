# https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/description/


import pandas as pd


def count_seniors_and_juniors(candidates: pd.DataFrame) -> pd.DataFrame:
    budget = 70000

    out = []
    for exp in ("Senior", "Junior"):
        hired = 0

        for sal in (
            candidates.loc[candidates.experience == exp].sort_values("salary").salary
        ):
            if sal <= budget:
                budget -= sal
                hired += 1
            else:
                break

        out.append({"experience": exp, "accepted_candidates": hired})

    return pd.DataFrame(out)
