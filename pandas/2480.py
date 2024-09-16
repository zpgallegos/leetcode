# https://leetcode.com/problems/form-a-chemical-bond/description/

import pandas as pd


def form_bond(elements: pd.DataFrame) -> pd.DataFrame:
    return (
        elements.query("type == 'Metal'")
        .merge(elements.query("type == 'Nonmetal'"), how="cross", suffixes=["_x", "_y"])
        .rename(columns={"symbol_x": "metal", "symbol_y": "nonmetal"})[
            ["metal", "nonmetal"]
        ]
    )


from itertools import product


def form_bond(elements: pd.DataFrame) -> pd.DataFrame:
    get = lambda _type: list(elements.query(f"type == '{_type}'").symbol)
    m, nm = (get(k) for k in ("Metal", "Nonmetal"))

    return pd.DataFrame(product(m, nm), columns=["metal", "nonmetal"])


# https://leetcode.com/problems/form-a-chemical-bond/

import pandas as pd


def form_bond(elements: pd.DataFrame) -> pd.DataFrame:
    metals = set(elements.loc[elements.type == "Metal", "symbol"])
    nonmetals = set(elements.loc[elements.type == "Nonmetal", "symbol"])

    x, y = zip(*[(m, nm) for m in metals for nm in nonmetals])

    return pd.DataFrame({"metal": x, "nonmetal": y})
