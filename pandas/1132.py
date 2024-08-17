# https://leetcode.com/problems/reported-posts-ii/


import pandas as pd


def reported_posts(actions: pd.DataFrame, removals: pd.DataFrame) -> pd.DataFrame:
    d = (
        actions.query("extra == 'spam'")[["post_id", "action_date"]]
        .drop_duplicates()
        .merge(removals, on="post_id", how="left")
        .groupby("action_date")
        .agg(n_reported=("post_id", "nunique"), n_removed=("remove_date", "count"))
    )
    d["prop"] = d.n_removed / d.n_reported

    ans = round(d.prop.mean() * 100, 2)

    return pd.DataFrame({"average_daily_percent": [ans]})
