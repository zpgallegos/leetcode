# https://leetcode.com/problems/convert-date-format/description/

import pandas as pd


def convert_date_format(days: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame({"day": days.day.dt.strftime("%A, %B %-d, %Y")})