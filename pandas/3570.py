# -- https://leetcode.com/problems/find-books-with-no-available-copies/description/

import pandas as pd


def find_books_with_no_available_copies(
    library_books: pd.DataFrame, borrowing_records: pd.DataFrame
) -> pd.DataFrame:
    cnts = (
        borrowing_records[borrowing_records.return_date.isnull()]
        .groupby("book_id")
        .size()
        .reset_index()
        .rename(columns={0: "current_borrowers"})
    )

    return (
        library_books.merge(cnts, on="book_id")
        .query("total_copies == current_borrowers")
        .drop("total_copies", axis=1)
        .sort_values(["current_borrowers", "title"], ascending=[False, True])
    )
