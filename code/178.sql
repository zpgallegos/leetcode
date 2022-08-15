select
    a.score,
    sub.rank
from
    Scores a
    inner join (
        select
            s.score,
            row_number() over(
                order by
                    s.score desc
            ) as "rank"
        from
            (
                select
                    distinct score
                from
                    Scores
            ) s
    ) sub on a.score = sub.score
order by
    a.score desc;