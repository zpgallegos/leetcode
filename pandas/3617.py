# https://leetcode.com/problems/find-students-with-study-spiral-pattern/

import numpy as np
import pandas as pd


def find_study_spiral_pattern(
    students: pd.DataFrame, study_sessions: pd.DataFrame
) -> pd.DataFrame:

    study_sessions = study_sessions.sort_values(
        ["student_id", "session_date", "session_id"]
    ).assign(
        session_date=lambda df: pd.to_datetime(df["session_date"]),
        day_diff=lambda df: (
            df["session_date"] - df.groupby("student_id")["session_date"].shift(1)
        ).dt.days,
    )

    res = []
    for student_id, grp in study_sessions.groupby("student_id"):
        if grp.day_diff.max() > 2:
            continue

        i = 0
        first_subject = None
        cycle_length = None
        n = len(grp)

        for row in grp.itertuples():
            if not first_subject:
                first_subject = row.subject

            if first_subject and not cycle_length and first_subject == row.subject:
                cycle_length = i

            if cycle_length and cycle_length >= 3:
                if not n % cycle_length == 0:
                    break

                if not grp.subject.nunique() == cycle_length:
                    break

                cycles = int(n / cycle_length)
                subj = grp.subject.to_numpy()
                first_cycle = subj[0:cycle_length]

                is_cycle = True
                for k in range(cycles)[1:]:
                    left = k * cycle_length
                    if not np.array_equal(
                        first_cycle, subj[left : left + cycle_length]
                    ):
                        is_cycle = False
                        break

                if is_cycle:
                    res.append(
                        {
                            "student_id": student_id,
                            "cycle_length": cycle_length,
                            "total_study_hours": grp.hours_studied.sum(),
                        }
                    )

                break

            i += 1

    out_cols = [
        "student_id",
        "student_name",
        "major",
        "cycle_length",
        "total_study_hours",
    ]

    if res:
        return (
            pd.DataFrame(res)
            .merge(students, on="student_id")
            .sort_values(
                ["cycle_length", "total_study_hours"], ascending=[False, False]
            )[out_cols]
        )

    return pd.DataFrame(columns=out_cols)
