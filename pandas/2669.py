# https://leetcode.com/problems/count-artist-occurrences-on-spotify-ranking-list/description/

import pandas as pd


def count_occurrences(spotify: pd.DataFrame) -> pd.DataFrame:
    return (
        spotify.artist.value_counts()
        .rename("occurrences")
        .reset_index()
        .sort_values(["occurrences", "artist"], ascending=[False, True])
    )

