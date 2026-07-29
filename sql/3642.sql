-- https://leetcode.com/problems/find-books-with-polarized-opinions/description/


with stats as (
    select
        book_id,
        max(session_rating) - min(session_rating) as rating_spread,
        count(1) filter (
            where session_rating <= 2 or session_rating >= 4
        )::numeric / count(1) as polarization_score
    from reading_sessions
    group by 1
    having
        1=1
        and count(1) >= 5
        and min(session_rating) <= 2
        and max(session_rating) >= 4
)

select
    a.book_id,
    b.title,
    b.author,
    b.genre,
    b.pages,
    a.rating_spread,
    round(a.polarization_score, 2) as polarization_score
from stats a
inner join books b on a.book_id = b.book_id
where a.polarization_score >= 0.6
order by a.polarization_score desc, b.title desc;






