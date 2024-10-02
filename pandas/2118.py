# https://leetcode.com/problems/build-the-equation/description/

import pandas as pd


def build_the_equation(terms: pd.DataFrame) -> pd.DataFrame:

    def build(row) -> str:
        s = "+" if row.factor > 0 else "-"
        f = abs(row.factor)
        p = "" if row.power == 0 else "X" if row.power == 1 else f"X^{row.power}"
        return f"{s}{f}{p}"

    eq = terms.sort_values("power", ascending=False).apply(build, axis=1).sum() + "=0"

    return pd.DataFrame({"equation": [eq]})
