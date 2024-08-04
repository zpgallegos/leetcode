# https://leetcode.com/problems/countries-you-can-safely-invest-in/

import pandas as pd


def find_safe_countries(
    person: pd.DataFrame, country: pd.DataFrame, calls: pd.DataFrame
) -> pd.DataFrame:
    country = country.rename(columns={"name": "country"})
    person["country_code"] = person.phone_number.str.slice(0, 3)
    person = person.merge(country, on="country_code")

    d = pd.concat(
        (
            calls[[col, "duration"]].rename(columns={col: "id"})
            for col in ["caller_id", "callee_id"]
        ),
        axis=0,
    ).merge(person, on="id")

    agg = d.groupby("country").duration.mean()
    agg = agg[agg > d.duration.mean()]

    return pd.DataFrame(agg.index, columns=["country"])
