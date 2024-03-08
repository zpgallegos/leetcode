# https://leetcode.com/problems/top-three-wineries/

import pandas as pd

from itertools import product


def top_three_wineries(wineries: pd.DataFrame) -> pd.DataFrame:
    LABS = {
        0: "top_winery",
        1: "second_winery",
        2: "third_winery",
    }
    TOP = len(LABS)
    FILLS = {
        1: "No second winery",
        2: "No third winery",
    }

    idx = pd.MultiIndex.from_tuples(
        product(wineries.country.unique(), range(TOP)),
        names=["country", "rnk"],
    )

    grpd = wineries.groupby(["country", "winery"]).points.sum().reset_index()

    grpd["rnk"] = (
        grpd.sort_values(["country", "points", "winery"], ascending=[True, False, True])
        .groupby("country")
        .cumcount()
    )

    out = grpd[grpd.rnk < TOP].set_index(["country", "rnk"]).reindex(idx).reset_index()
    out["lbl"] = out.apply(
        lambda row: (
            f"{row.winery} ({row.points})" if pd.notnull(row.winery) else row.winery
        ),
        axis=1,
    )
    out["lbl"] = out.lbl.fillna(out.rnk.map(FILLS))
    out = out.pivot(index="country", columns="rnk", values="lbl")
    out.columns = [LABS.get(col, col) for col in out.columns]

    return out.reset_index().sort_values("country")
