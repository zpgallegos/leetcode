# https://leetcode.com/problems/calculate-parking-fees-and-duration/

import pandas as pd


def calculate_fees_and_duration(parking_transactions: pd.DataFrame) -> pd.DataFrame:
    parking_transactions["hours"] = (
        parking_transactions.exit_time - parking_transactions.entry_time
    ).dt.total_seconds() / (60 * 60)

    lot = parking_transactions.groupby(["car_id", "lot_id"]).agg(
        total_hours=("hours", "sum")
    )
    max_hours_lot = (
        lot.loc[lot.groupby("car_id").total_hours.idxmax()].reset_index(level=1).lot_id
    )

    car = parking_transactions.groupby("car_id").agg(
        total_fee_paid=("fee_paid", "sum"), total_hours=("hours", "sum")
    )
    car["avg_hourly_fee"] = (car.total_fee_paid / car.total_hours).round(2)
    car["most_time_lot"] = max_hours_lot

    return car.reset_index().drop("total_hours", axis=1).sort_values("car_id")
