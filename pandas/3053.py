# https://leetcode.com/problems/classifying-triangles-by-lengths/description/

import pandas as pd


def classify_triangle(a, b, c):
    if a + b <= c or a + c <= b or b + c <= a:
        return "Not A Triangle"
    if a == b and b == c:
        return "Equilateral"
    if a == b or a == c or b == c:
        return "Isosceles"
    return "Scalene"


def type_of_triangle(triangles: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame(
        {
            "triangle_type": triangles.apply(
                lambda row: classify_triangle(row.A, row.B, row.C), axis=1
            )
        }
    )
