# https://leetcode.com/problems/form-a-chemical-bond/

import pandas as pd


def form_bond(elements: pd.DataFrame) -> pd.DataFrame:
    metals = set(elements.loc[elements.type == "Metal", "symbol"])
    nonmetals = set(elements.loc[elements.type == "Nonmetal", "symbol"])

    x, y = zip(*[(m, nm) for m in metals for nm in nonmetals])

    return pd.DataFrame({"metal": x, "nonmetal": y})
