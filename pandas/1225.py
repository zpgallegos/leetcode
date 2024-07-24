# https://leetcode.com/problems/report-contiguous-dates/

import pandas as pd


def report_contiguous_dates(
    failed: pd.DataFrame, succeeded: pd.DataFrame
) -> pd.DataFrame:
    qry = lambda col: f"{col} >= '2019-01-01' and {col} <= '2019-12-31'"

    failed = failed.query(qry("fail_date"))
    failed["period_state"] = "failed"

    succeeded = succeeded.query(qry("success_date"))
    succeeded["period_state"] = "succeeded"

    d = pd.concat(
        (
            failed.rename(columns={"fail_date": "date"}),
            succeeded.rename(columns={"success_date": "date"}),
        ),
        axis=0,
    ).sort_values("date")

    d["lag"] = d.period_state.shift(1)
    d["chg"] = d.apply(
        lambda row: pd.isnull(row.lag) or row.lag != row.period_state, axis=1
    )
    d["grp"] = d.chg.cumsum()

    return (
        d.groupby(["period_state", "grp"])
        .agg(start_date=("date", "min"), end_date=("date", "max"))
        .reset_index()
        .drop("grp", axis=1)
        .sort_values("start_date")
    )
