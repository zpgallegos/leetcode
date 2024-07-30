# https://leetcode.com/problems/students-report-by-geography/


import pandas as pd


def geography_report(student: pd.DataFrame) -> pd.DataFrame:
    student = student.sort_values(["continent", "name"])
    student["i"] = student.groupby("continent").cumcount()

    out = student.pivot_table(
        index="i", columns="continent", values="name", aggfunc=lambda x: x
    )

    # no way to avoid this hardcode if these columns are known to be
    # desired in the output but not guaranteed to be present in the input
    cols = ["America", "Asia", "Europe"]
    
    for col in cols:
        if col not in out.columns:
            out[col] = None

    return out[cols]
