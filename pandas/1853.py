# https://leetcode.com/problems/convert-date-format/description/

import pandas as pd


def format_date(date):
    day = str(int(date.strftime("%d")))
    return date.strftime(f"%A, %B {day}, %Y")


def convert_date_format(days: pd.DataFrame) -> pd.DataFrame:
    days["day"] = days.day.apply(format_date)
    return days
