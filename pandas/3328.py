# https://leetcode.com/problems/find-cities-in-each-state-ii/description/

import pandas as pd


def state_city_analysis(cities: pd.DataFrame) -> pd.DataFrame:
    cities["mtch"] = cities.apply(lambda row: row.state[0] == row.city[0], axis=1)

    tbl = (
        cities.groupby("state")
        .agg(
            cnt=("city", len),
            cities=("city", lambda x: ", ".join(sorted(x))),
            matching_letter_count=("mtch", sum),
        )
        .reset_index()
    )

    return (
        tbl[(tbl.cnt >= 3) & (tbl.matching_letter_count > 0)]
        .drop("cnt", axis=1)
        .sort_values(["matching_letter_count", "state"], ascending=[False, True])
    )
