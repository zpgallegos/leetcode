# https://leetcode.com/problems/the-first-day-of-the-maximum-recorded-degree-in-each-city/description/


import pandas as pd


def find_the_first_day(weather: pd.DataFrame) -> pd.DataFrame:
    weather = weather.sort_values(
        ["city_id", "degree", "day"], ascending=[True, False, True]
    )

    return weather.groupby("city_id").first().sort_index().reset_index()
