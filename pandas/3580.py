# https://leetcode.com/problems/find-consistently-improving-employees/description/


import pandas as pd


def find_consistently_improving_employees(
    employees: pd.DataFrame, performance_reviews: pd.DataFrame
) -> pd.DataFrame:

    reviews = performance_reviews.sort_values(
        ["employee_id", "review_date", "review_id"]
    )

    ratings = reviews.groupby("employee_id", sort=False).rating

    reviews = reviews.assign(rating_1=ratings.shift(1), rating_2=ratings.shift(2))

    return (
        reviews.groupby("employee_id", sort=False)
        .tail(1)
        .query("rating > rating_1 and rating_1 > rating_2")
        .assign(improvement_score=lambda df: df.rating - df.rating_2)
        .merge(employees, on="employee_id")
        .sort_values(["improvement_score", "name"], ascending=[False, True])[
            ["employee_id", "name", "improvement_score"]
        ]
    )
