# https://leetcode.com/problems/all-valid-triplets-that-can-represent-a-country/

import pandas as pd


def find_valid_triplets(
    school_a: pd.DataFrame, school_b: pd.DataFrame, school_c: pd.DataFrame
) -> pd.DataFrame:

    df = school_a.merge(
        school_b.merge(school_c, how="cross", suffixes=["_b", "_c"]), how="cross"
    )

    return df[
        (df.student_id != df.student_id_b)
        & (df.student_id != df.student_id_c)
        & (df.student_id_b != df.student_id_c)
        & (df.student_name != df.student_name_b)
        & (df.student_name != df.student_name_c)
        & (df.student_name_b != df.student_name_c)
    ][["student_name", "student_name_b", "student_name_c"]].rename(
        columns={
            "student_name": "member_A",
            "student_name_b": "member_B",
            "student_name_c": "member_C",
        }
    )
