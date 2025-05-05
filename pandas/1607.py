# https://leetcode.com/problems/sellers-with-no-sales/description/


import pandas as pd


def sellers_with_no_sales(
    customer: pd.DataFrame, orders: pd.DataFrame, seller: pd.DataFrame
) -> pd.DataFrame:
    return seller.loc[
        ~seller.seller_id.isin(
            orders.query(
                "sale_date >= '2020-01-01' and sale_date <= '2020-12-31'"
            ).seller_id.unique()
        ),
        ["seller_name"],
    ].sort_values("seller_name")
