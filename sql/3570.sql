-- https://leetcode.com/problems/find-books-with-no-available-copies/description/

with borrowed_counts as (
    select book_id, count(1) as current_borrowers
    from borrowing_records
    where return_date is null
    group by book_id
)

select
    a.book_id,
    a.title,
    a.author,
    a.genre,
    a.publication_year,
    b.current_borrowers
from library_books a
inner join borrowed_counts b on a.book_id = b.book_id
where b.current_borrowers = a.total_copies
order by 6 desc, 2;