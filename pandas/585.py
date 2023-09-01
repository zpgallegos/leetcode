# https://leetcode.com/problems/investments-in-2016/?lang=pythondata?envType=daily-question&envId=2023-09-01

import pandas as pd


def find_investments(insurance: pd.DataFrame) -> pd.DataFrame:
    sub = insurance[
        (insurance.duplicated(subset="tiv_2015", keep=False)) &
        (~insurance.duplicated(subset=["lat", "lon"], keep=False))
    ]
    return pd.DataFrame({"tiv_2016": sub.tiv_2016.sum()}, index=[0])