# https://leetcode.com/problems/arrange-table-by-gender/


import pandas as pd


def arrange_table(genders: pd.DataFrame) -> pd.DataFrame:

    dfs = []
    for g, grp in genders.groupby("gender"):
        i = 0 if g == "female" else 1 if g == "other" else 2

        n, _ = grp.shape
        df = grp.copy().sort_values("user_id")
        df["idx"] = range(i, i + n * 3, 3)

        dfs.append(df)

    return pd.concat(dfs, axis=0).sort_values("idx").drop("idx", axis=1)


# https://leetcode.com/problems/arrange-table-by-gender/

import pandas as pd


def arrange_table(genders: pd.DataFrame) -> pd.DataFrame:
    genders = genders.sort_values(["gender", "user_id"])

    genders["idx"] = genders.groupby("gender").cumcount() + genders.gender.apply(
        lambda x: 0.01 if x == "other" else 0.1 if x == "male" else 0
    )

    return genders.sort_values("idx").drop("idx", axis=1)
