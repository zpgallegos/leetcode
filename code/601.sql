-- https://leetcode.com/problems/human-traffic-of-stadium/

with cte as (
    select
        *,
        id - row_number() over(order by id) as grp
    from stadium
    where people >= 100
)

select
    id,
    visit_date,
    people
from cte
where grp in (
    select grp 
    from cte
    group by grp
    having count(1) >= 3
);
