# https://leetcode.com/problems/find-books-with-polarized-opinions/description/

import pandas as pd


def find_polarized_books(
    books: pd.DataFrame, reading_sessions: pd.DataFrame
) -> pd.DataFrame:

    session_counts = reading_sessions.groupby("book_id")["session_id"].nunique()

    return (
        reading_sessions[
            reading_sessions.book_id.isin(session_counts[session_counts.ge(5)].index)
        ]
        .assign(
            is_low=reading_sessions.session_rating.le(2),
            is_high=reading_sessions.session_rating.ge(4),
        )
        .groupby("book_id")
        .agg(
            n_low=("is_low", "sum"),
            n_high=("is_high", "sum"),
            n_ratings=("session_id", "count"),
            min_rating=("session_rating", "min"),
            max_rating=("session_rating", "max"),
        )
        .query("n_low > 0 and n_high > 0")
        .assign(
            rating_spread=lambda df: df.max_rating - df.min_rating,
            polarization_score=lambda df: (df.n_low + df.n_high).div(df.n_ratings),
        )
        .query("polarization_score >= .6")
        .assign(polarization_score=lambda df: df.polarization_score.add(1e-6).round(2))
        .merge(books, on="book_id")
        .sort_values(["polarization_score", "title"], ascending=[False, False])[
            [
                "book_id",
                "title",
                "author",
                "genre",
                "pages",
                "rating_spread",
                "polarization_score",
            ]
        ]
    )
