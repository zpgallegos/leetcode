# https://leetcode.com/problems/low-quality-problems/description/

import pandas as pd



def low_quality_problems(problems: pd.DataFrame) -> pd.DataFrame:
    return problems.loc[
        (problems.likes / (problems.likes + problems.dislikes)) < 0.60, ["problem_id"]
    ].sort_values("problem_id")
