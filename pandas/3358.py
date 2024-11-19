# https://leetcode.com/problems/books-with-null-ratings/description/

import pandas as pd


def find_unrated_books(books: pd.DataFrame) -> pd.DataFrame:
    return books[books.rating.isna()].drop("rating", axis=1).sort_values("book_id")
