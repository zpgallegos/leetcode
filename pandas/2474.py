# https://leetcode.com/problems/customers-with-strictly-increasing-purchases/description/

import pandas as pd


def find_specific_customers(orders: pd.DataFrame) -> pd.DataFrame:
    orders["year"] = orders.order_date.dt.year

    tbl = orders.groupby(["customer_id", "year"]).price.sum().sort_index()
    custs = set(tbl.index.levels[0])
    tbl = tbl.reset_index()

    grp = tbl.groupby("customer_id")
    tbl["year_diff"] = grp.year.diff(1)
    tbl["price_diff"] = grp.price.diff(1)

    # they cannot have strictly increasing purchases with a zero year
    disqual = set(tbl.loc[(tbl.year_diff > 1) | (tbl.price_diff <= 0), "customer_id"])

    return pd.DataFrame({"customer_id": list(custs - disqual)})


def find_specific_customers(orders: pd.DataFrame) -> pd.DataFrame:
    """doing an unnecessary reindex to fill zero years"""
    orders["year"] = orders.order_date.dt.year

    agg = orders.groupby(["customer_id", "year"]).price.sum().sort_index()

    bounds = (
        agg.reset_index()
        .groupby("customer_id")
        .agg(lower=("year", "min"), upper=("year", "max"))
    )

    mdx = pd.MultiIndex.from_frame(
        pd.concat(
            (
                pd.DataFrame(
                    {
                        "customer_id": row.Index,
                        "year": range(row.lower, row.upper + 1),
                    }
                )
                for row in bounds.itertuples()
            ),
            axis=0,
        )
    )

    agg = agg.reindex(mdx, fill_value=0).to_frame()
    agg["last_price"] = agg.groupby("customer_id").price.shift(1)

    rem = set(agg[agg.price <= agg.last_price].index.get_level_values(0))

    return pd.DataFrame({"customer_id": list(set(agg.index.levels[0]) - rem)})
