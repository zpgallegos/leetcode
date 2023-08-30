# https://leetcode.com/problems/trips-and-users/?lang=pythondata

import pandas as pd


def cancellation_rate(grp: pd.DataFrame):
    return grp.status.str.startswith("cancelled").mean().round(2)


def trips_and_users(trips: pd.DataFrame, users: pd.DataFrame) -> pd.DataFrame:
    banned = set(users.query("banned == 'Yes'").users_id)
    t = trips[
        (~trips.client_id.isin(banned))
        & (~trips.driver_id.isin(banned))
        & (trips.request_at >= "2013-10-01")
        & (trips.request_at <= "2013-10-03")
    ]
    g = t.groupby("request_at").apply(cancellation_rate)
    if g.empty:
        return pd.DataFrame(None, columns=["Day", "Cancellation Rate"])
    return g.reset_index(name="Cancellation Rate").rename(columns={"request_at": "Day"})
