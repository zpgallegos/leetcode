# https://leetcode.com/problems/hopper-company-queries-ii/description/


import pandas as pd


def hopper_company_queries(
    drivers: pd.DataFrame, rides: pd.DataFrame, accepted_rides: pd.DataFrame
) -> pd.DataFrame:
    begin = "2020-01-01"
    end = "2020-12-31"
    all_months = range(1, 13)

    drivers["month"] = drivers.join_date.dt.month
    rides["month"] = rides.requested_at.dt.month

    drivers = drivers.sort_values("join_date")
    drivers["i"] = [i + 1 for i in range(len(drivers))]

    driver_counts = (
        drivers.query(f"join_date >= '{begin}' and join_date <= '{end}'")
        .groupby("month")
        .agg(driver_count=("i", "max"))
        .reindex(all_months, fill_value=0)
        .sort_index()
    )
    driver_counts["driver_count"] = driver_counts.driver_count.cummax()

    drove_counts = (
        rides.query(f"requested_at >= '{begin}' and requested_at <= '{end}'")
        .merge(accepted_rides, on="ride_id")
        .groupby("month")
        .driver_id.nunique()
        .reindex(all_months, fill_value=0)
    )

    out = []
    for cnt, drv in zip(driver_counts.driver_count, drove_counts):
        perc = 0 if cnt == 0 else round((drv / cnt) * 100, 2)
        out.append(perc)

    return pd.DataFrame({"month": all_months, "working_percentage": out})



# https://leetcode.com/problems/hopper-company-queries-ii/


import pandas as pd

data = [
    [10, "2019-12-10"],
    [8, "2020-1-13"],
    [5, "2020-2-16"],
    [7, "2020-3-8"],
    [4, "2020-5-17"],
    [1, "2020-10-24"],
    [6, "2021-1-5"],
]
drivers = pd.DataFrame(data, columns=["driver_id", "join_date"]).astype(
    {"driver_id": "Int64", "join_date": "datetime64[ns]"}
)
data = [
    [6, 75, "2019-12-9"],
    [1, 54, "2020-2-9"],
    [10, 63, "2020-3-4"],
    [19, 39, "2020-4-6"],
    [3, 41, "2020-6-3"],
    [13, 52, "2020-6-22"],
    [7, 69, "2020-7-16"],
    [17, 70, "2020-8-25"],
    [20, 81, "2020-11-2"],
    [5, 57, "2020-11-9"],
    [2, 42, "2020-12-9"],
    [11, 68, "2021-1-11"],
    [15, 32, "2021-1-17"],
    [12, 11, "2021-1-19"],
    [14, 18, "2021-1-27"],
]
rides = pd.DataFrame(data, columns=["ride_id", "user_id", "requested_at"]).astype(
    {"ride_id": "Int64", "user_id": "Int64", "requested_at": "datetime64[ns]"}
)
data = [
    [10, 10, 63, 38],
    [13, 10, 73, 96],
    [7, 8, 100, 28],
    [17, 7, 119, 68],
    [20, 1, 121, 92],
    [5, 7, 42, 101],
    [2, 4, 6, 38],
    [11, 8, 37, 43],
    [15, 8, 108, 82],
    [12, 8, 38, 34],
    [14, 1, 90, 74],
]
accepted_rides = pd.DataFrame(
    data, columns=["ride_id", "driver_id", "ride_distance", "ride_duration"]
).astype(
    {
        "ride_id": "Int64",
        "driver_id": "Int64",
        "ride_distance": "Int64",
        "ride_duration": "Int64",
    }
)


def hopper_company_queries(
    drivers: pd.DataFrame, rides: pd.DataFrame, accepted_rides: pd.DataFrame
) -> pd.DataFrame:
    start = "2020-01-01"
    end = "2020-12-31"

    rides = rides.query(f"requested_at >= '{start}' and requested_at <= '{end}'").merge(
        accepted_rides, on="ride_id"
    )
    rides["month"] = rides.requested_at.dt.month

    working_cnts = (
        rides.groupby("month").driver_id.nunique().reindex(range(1, 13)).fillna(0)
    )

    driver_cnts = pd.DataFrame({"month_start": pd.date_range(start, end, freq="1M")})
    driver_cnts["month"] = driver_cnts.month_start.dt.month
    driver_cnts["driver_cnt"] = driver_cnts.month_start.apply(
        lambda x: (drivers.join_date <= x).sum()
    )

    out = driver_cnts.set_index("month")
    out["working_cnt"] = working_cnts
    out["working_percentage"] = round(
        (out.working_cnt / out.driver_cnt) * 100, 2
    ).fillna(0)

    return out.reset_index()[["month", "working_percentage"]]
