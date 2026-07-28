# https://leetcode.com/problems/find-covid-recovery-patients/


import pandas as pd


def find_covid_recovery_patients(
    patients: pd.DataFrame, covid_tests: pd.DataFrame
) -> pd.DataFrame:

    covid_tests["test_date"] = pd.to_datetime(covid_tests.test_date)

    pos = (
        covid_tests.query("result == 'Positive'")
        .groupby("patient_id")
        .test_date.min()
        .rename("pos_date")
        .reset_index()
    )

    return (
        covid_tests.query("result == 'Negative'")
        .merge(pos, on="patient_id")
        .query("test_date > pos_date")
        .groupby(["patient_id", "pos_date"])
        .test_date.min()
        .rename("neg_date")
        .reset_index()
        .merge(patients, on="patient_id")
        .assign(recovery_time=lambda df: (df.neg_date - df.pos_date).dt.days)
        .sort_values(["recovery_time", "patient_name"])[
            ["patient_id", "patient_name", "age", "recovery_time"]
        ]
    )
