# https://leetcode.com/problems/count-occurrences-in-text/

import pandas as pd


def count_occurrences(files: pd.DataFrame) -> pd.DataFrame:
    match_count = lambda word: files.content.str.contains(" " + word + " ").sum()

    return pd.DataFrame(
        [{"word": word, "count": match_count(word)} for word in ["bull", "bear"]]
    )
