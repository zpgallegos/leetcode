# https://leetcode.com/problems/dna-pattern-recognition/description/

import pandas as pd


def analyze_dna_patterns(samples: pd.DataFrame) -> pd.DataFrame:
    has = lambda p: samples.dna_sequence.str.contains(p).astype(int)

    samples["has_start"] = has(r"^ATG")
    samples["has_stop"] = has(r"T[AG]{2}$")
    samples["has_atat"] = has(r"ATAT")
    samples["has_ggg"] = has(r"G{3,}")

    return samples.sort_values("sample_id")
