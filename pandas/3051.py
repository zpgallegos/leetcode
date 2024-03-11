# https://leetcode.com/problems/find-candidates-for-data-scientist-position/description/

import pandas as pd

from functools import reduce


def find_candidates(candidates: pd.DataFrame) -> pd.DataFrame:
    skills = ["Python", "Tableau", "PostgreSQL"]
    
    return pd.DataFrame(
        {
            "candidate_id": list(
                reduce(
                    lambda x, y: x.intersection(y),
                    (
                        set(candidates.query(f"skill == '{skill}'").candidate_id)
                        for skill in skills
                    ),
                )
            )
        }
    ).sort_values("candidate_id")
