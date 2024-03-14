# https://leetcode.com/problems/highest-salaries-difference/description/

import pandas as pd


def salaries_difference(salaries: pd.DataFrame) -> pd.DataFrame:
    return pd.DataFrame(
        {
            "salary_difference": [
                abs(
                    salaries[salaries.department == "Engineering"].salary.max()
                    - salaries[salaries.department == "Marketing"].salary.max()
                )
            ]
        }
    )
