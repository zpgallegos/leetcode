# https://leetcode.com/problems/the-category-of-each-member-in-the-store/description/

import pandas as pd


def find_categories(
    members: pd.DataFrame, visits: pd.DataFrame, purchases: pd.DataFrame
) -> pd.DataFrame:
    tbl = (
        members.merge(visits, on="member_id", how="left")
        .merge(purchases, on="visit_id", how="left")
        .groupby(["member_id", "name"])
        .agg(visits=("visit_id", "nunique"), purchases=("charged_amount", "count"))
        .reset_index()
    )
    tbl["conv"] = (100 * tbl.purchases) / tbl.visits
    tbl["category"] = tbl.apply(
        lambda row: (
            "Bronze"
            if row.visits == 0
            else "Diamond" if row.conv >= 80 else "Gold" if row.conv >= 50 else "Silver"
        ),
        axis=1,
    )

    return tbl[["member_id", "name", "category"]]
