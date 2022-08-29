-- https://leetcode.com/problems/human-traffic-of-stadium/

with cte as (
    select
        *,
        id - row_number() over(order by id) as grp
    from stadium
    where people >= 100
), cte2 as (
    select
        *,
        count(1) over(partition by grp) >= 3 as incl
    from cte
)

select id, visit_date, people
from cte2
where incl
order by visit_date;


