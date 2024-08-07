# https://leetcode.com/problems/build-the-equation/

import pandas as pd


def build_the_equation(terms: pd.DataFrame) -> pd.DataFrame:

    def build(row):
        sign = "+" if row.factor > 0 else "-"
        fac = abs(row.factor)
        power = "" if row.power == 0 else "X" if row.power == 1 else f"X^{row.power}"
        return f"{sign}{fac}{power}"

    terms["term"] = terms.apply(build, axis=1)

    return pd.DataFrame(
        {"equation": [terms.sort_values("power", ascending=False).term.sum() + "=0"]}
    )
