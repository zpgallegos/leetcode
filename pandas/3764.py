# https://leetcode.com/problems/most-common-course-pairs/

import pandas as pd

course_completions_data = [
    [1, 101, "Python Basics", "2024-01-05", 5],
    [1, 102, "SQL Fundamentals", "2024-02-10", 4],
    [1, 103, "JavaScript", "2024-03-15", 5],
    [1, 104, "React Basics", "2024-04-20", 4],
    [1, 105, "Node.js", "2024-05-25", 5],
    [1, 106, "Docker", "2024-06-30", 4],
    [2, 101, "Python Basics", "2024-01-08", 4],
    [2, 104, "React Basics", "2024-02-14", 5],
    [2, 105, "Node.js", "2024-03-20", 4],
    [2, 106, "Docker", "2024-04-25", 5],
    [2, 107, "AWS Fundamentals", "2024-05-30", 4],
    [3, 101, "Python Basics", "2024-01-10", 3],
    [3, 102, "SQL Fundamentals", "2024-02-12", 3],
    [3, 103, "JavaScript", "2024-03-18", 3],
    [3, 104, "React Basics", "2024-04-22", 2],
    [3, 105, "Node.js", "2024-05-28", 3],
    [4, 101, "Python Basics", "2024-01-12", 5],
    [4, 108, "Data Science", "2024-02-16", 5],
    [4, 109, "Machine Learning", "2024-03-22", 5],
]
course_completions = pd.DataFrame(
    course_completions_data,
    columns=[
        "user_id",
        "course_id",
        "course_name",
        "completion_date",
        "course_rating",
    ],
).astype(
    {
        "user_id": "int64",
        "course_id": "int64",
        "course_name": "string",
        "completion_date": "datetime64[ns]",
        "course_rating": "Int64",
    }
)


def topLearnerCourseTransitions(course_completions: pd.DataFrame) -> pd.DataFrame:

    qual = (
        course_completions.groupby("user_id")
        .agg(
            course_count=("course_id", "count"),
            mean_rating=("course_rating", "mean"),
        )
        .query("course_count >= 5 and mean_rating >= 4")
    )

    return (
        course_completions[course_completions.user_id.isin(qual.index)]
        .sort_values(["user_id", "completion_date", "course_id"])
        .assign(second_course=lambda df: df.groupby("user_id").course_name.shift(-1))
        .groupby(["course_name", "second_course"], as_index=False)
        .agg(transition_count=("course_id", "count"))
        .sort_values(
            ["transition_count", "course_name", "second_course"],
            ascending=[False, True, True],
            key=lambda col: col if col.name == "transition_count" else col.str.lower(),
        )
        .rename(columns={"course_name": "first_course"})
    )
