# https://leetcode.com/problems/find-top-scoring-students-ii/description/


import pandas as pd


data = [
    [1, "Alice", "Computer Science"],
    [2, "Bob", "Computer Science"],
    [3, "Charlie", "Mathematics"],
    [4, "David", "Mathematics"],
]
students = pd.DataFrame(data, columns=["student_id", "name", "major"]).astype(
    {
        "student_id": "Int64",  # Nullable integer type for student_id
        "name": "string",  # String type for names
        "major": "string",  # String type for majors
    }
)
data = [
    [101, "Algorithms", 3, "Computer Science", "Yes"],
    [102, "Data Structures", 3, "Computer Science", "Yes"],
    [103, "Calculus", 4, "Mathematics", "Yes"],
    [104, "Linear Algebra", 4, "Mathematics", "Yes"],
    [105, "Machine Learning", 3, "Computer Science", "No"],
    [106, "Probability", 3, "Mathematics", "No"],
    [107, "Operating Systems", 3, "Computer Science", "No"],
    [108, "Statistics", 3, "Mathematics", "No"],
]
courses = pd.DataFrame(
    data, columns=["course_id", "name", "credits", "major", "mandatory"]
).astype(
    {
        "course_id": "Int64",
        "name": "string",
        "credits": "Int64",
        "major": "string",
        "mandatory": "string",
    }
)

# pd.CategoricalDtype(categories=['yes', 'no'])

data = [
    [1, 101, "Fall 2023", "A", 4.0],
    [1, 102, "Spring 2023", "A", 4.0],
    [1, 105, "Spring 2023", "A", 4.0],
    [1, 107, "Fall 2023", "B", 3.5],
    [2, 101, "Fall 2023", "A", 4.0],
    [2, 102, "Spring 2023", "B", 3.0],
    [3, 103, "Fall 2023", "A", 4.0],
    [3, 104, "Spring 2023", "A", 4.0],
    [3, 106, "Spring 2023", "A", 4.0],
    [3, 108, "Fall 2023", "B", 3.5],
    [4, 103, "Fall 2023", "B", 3.0],
    [4, 104, "Spring 2023", "B", 3.0],
]
enrollments = pd.DataFrame(
    data, columns=["student_id", "course_id", "semester", "grade", "GPA"]
).astype(
    {
        "student_id": "Int64",
        "course_id": "Int64",
        "semester": "string",
        "grade": "string",
        "GPA": "float",
    }
)


def find_top_scoring_students(
    students: pd.DataFrame, courses: pd.DataFrame, enrollments: pd.DataFrame
) -> pd.DataFrame:
    d = students.merge(enrollments, on="student_id").merge(courses, on="course_id")

    d["is_major"] = d["major_x"] == d["major_y"]
    d["is_mandatory"] = d["mandatory"] == "Yes"
    d["is_a"] = d["grade"] == "A"
    d["is_ab"] = d["grade"].isin(["A", "B"])
    d["crit_1"] = d["is_major"] & d["is_mandatory"] & ~d["is_a"]
    d["crit_2"] = d["is_major"] & ~d["is_mandatory"] & ~d["is_ab"]

    tbl = (
        d[d.is_major]
        .groupby(["student_id", "major_x"])
        .agg(
            mandatory_taken=("is_mandatory", "sum"),
            elective_taken=("is_mandatory", lambda x: (~x).sum()),
        )
    )
    tbl["req"] = tbl.index.get_level_values(1).map(
        courses[courses.mandatory == "Yes"].groupby("major").course_id.nunique()
    )
    out = set(
        tbl[
            (tbl.mandatory_taken == tbl.req) & (tbl.elective_taken >= 2)
        ].index.get_level_values(0)
    )

    crit = d.groupby("student_id").agg(
        crit_1=("crit_1", "sum"), crit_2=("crit_2", "sum")
    )
    out = out.intersection(set(crit[(crit.crit_1 == 0) & (crit.crit_2 == 0)].index))

    gpa = d.groupby("student_id").GPA.mean()
    out = out.intersection(set(gpa[gpa >= 2.5].index))

    return pd.DataFrame({"student_id": list(out)}).sort_values("student_id")
