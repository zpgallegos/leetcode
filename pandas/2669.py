# https://leetcode.com/problems/count-artist-occurrences-on-spotify-ranking-list/

import pandas as pd


def count_occurrences(spotify: pd.DataFrame) -> pd.DataFrame:
    return (
        spotify.artist.value_counts()
        .reset_index()
        .rename(columns={"count": "occurrences"})
        .sort_values(["occurrences", "artist"], ascending=[False, True])
    )

