# https://leetcode.com/problems/active-users/


import pandas as pd


def active_users(accounts: pd.DataFrame, logins: pd.DataFrame) -> pd.DataFrame:
    req = 5

    logins = logins.drop_duplicates().sort_values(["id", "login_date"])
    logins["dif"] = logins.groupby("id").login_date.diff(1).dt.days
    logins["incr"] = logins.dif.apply(lambda x: 1 if pd.isnull(x) or x > 1 else 0)
    logins["grp"] = logins.incr.cumsum()

    vc = logins.groupby(["id", "grp"]).size()
    out = pd.DataFrame({"id": list(set(vc[vc >= req].index.get_level_values(0)))})
    out = out.merge(accounts, on="id")

    return out.sort_values("id")
