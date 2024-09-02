# https://leetcode.com/problems/find-candidates-for-data-scientist-position-ii/description/


import pandas as pd

data = [
    [101, "Python", 5],
    [101, "Tableau", 3],
    [101, "PostgreSQL", 4],
    [101, "TensorFlow", 2],
    [102, "Python", 4],
    [102, "Tableau", 5],
    [102, "PostgreSQL", 4],
    [102, "R", 4],
    [103, "Python", 3],
    [103, "Tableau", 5],
    [103, "PostgreSQL", 5],
    [103, "Spark", 4],
]
candidates = pd.DataFrame(data, columns=["candidate_id", "skill", "proficiency"])

data = [
    [501, "Python", 4],
    [501, "Tableau", 3],
    [501, "PostgreSQL", 5],
    [502, "Python", 3],
    [502, "Tableau", 4],
    [502, "R", 2],
]
projects = pd.DataFrame(data, columns=["project_id", "skill", "importance"])


def find_best_candidates(
    candidates: pd.DataFrame, projects: pd.DataFrame
) -> pd.DataFrame:

    cnts = projects.groupby("project_id").size().rename("skill_count").reset_index()

    tbl = projects.merge(candidates, on="skill")
    tbl["val"] = tbl.apply(
        lambda row: (
            10
            if row.proficiency > row.importance
            else -5 if row.proficiency < row.importance else 0
        ),
        axis=1,
    )

    out = (
        tbl.groupby(["project_id", "candidate_id"], as_index=False)
        .agg(skill_count=("candidate_id", len), score=("val", lambda x: 100 + x.sum()))
        .merge(cnts, on=["project_id", "skill_count"])
        .sort_values(["project_id", "score"], ascending=[True, False])
    )
    out["rnk"] = out.groupby("project_id").cumcount()

    return out[out.rnk == 0][["project_id", "candidate_id", "score"]]
