-- https://leetcode.com/problems/exchange-seats/

with cte as (
    select *, case when id % 2 = 1 then id + 1 else id - 1 end as jn
    from seat
)

select a.id, coalesce(b.student, a.student) as student
from cte a left join seat b on a.jn = b.id

-- another way, still relies on the odd/even id though

with cte as (
    select
        *,
        case when id % 2 = 1 then 1 else 0 end as use_next,
        lag(student, 1) over(order by id) as prev,
        coalesce(lead(student, 1) over(order by id), student) as nxt
    from seat
)

select id, case when use_next = 1 then nxt else prev end as student
from cte;