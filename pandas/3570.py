# -- https://leetcode.com/problems/find-books-with-no-available-copies/description/

import pandas as pd


def find_books_with_no_available_copies(
    library_books: pd.DataFrame, borrowing_records: pd.DataFrame
) -> pd.DataFrame:
    cnts = (
        borrowing_records[borrowing_records.return_date.isna()]
        .groupby("book_id")
        .size()
        .rename("current_borrowers")
        .reset_index()
    )

    return (
        library_books.merge(cnts, on="book_id")
        .query("total_copies == current_borrowers")
        .drop(columns="total_copies")
        .sort_values(["current_borrowers", "title"], ascending=[False, True])
    )
