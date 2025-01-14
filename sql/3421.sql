-- https://leetcode.com/problems/find-students-who-improved/


with

cte as (

    select
        a.student_id,
        a.subject,
        first_value(a.score) over win as first_score,
        last_value(a.score) over win as latest_score
    from scores a
    window win as (
        partition by a.student_id, a.subject order by a.date
        rows between unbounded preceding and unbounded following
    )

)

select distinct *
from cte
where latest_score > first_score
order by 1, 2;