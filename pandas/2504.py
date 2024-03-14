# https://leetcode.com/problems/concatenate-the-name-and-the-profession/

import pandas as pd


def concatenate_info(person: pd.DataFrame) -> pd.DataFrame:
    person["name"] = person.name + "(" + person.profession.str.slice(0, 1) + ")"
    return person[["person_id", "name"]].sort_values("person_id", ascending=False)
