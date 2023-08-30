# https://leetcode.com/problems/market-analysis-ii/?lang=pythondata

import pandas as pd


def market_analysis(
    users: pd.DataFrame, orders: pd.DataFrame, items: pd.DataFrame
) -> pd.DataFrame:
    out_col = "2nd_item_fav_brand"

    orders = orders.sort_values(["seller_id", "order_date"])
    orders["idx"] = orders.groupby("seller_id").cumcount()
    orders = orders.merge(users, left_on="seller_id", right_on="user_id").merge(
        items, on="item_id"
    )
    yes = orders[
        (orders.idx == 1) & (orders.item_brand == orders.favorite_brand)
    ].seller_id.unique()
    no = list(set(users.user_id) - set(yes))

    return pd.concat(
        (
            pd.DataFrame({"seller_id": yes, out_col: "yes"}),
            pd.DataFrame({"seller_id": no, out_col: "no"}),
        ),
        axis=0,
    ).sort_values("seller_id")
