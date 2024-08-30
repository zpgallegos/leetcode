-- https://leetcode.com/problems/human-traffic-of-stadium/

with cte as (
    select
        a.*,
        if(a.id - lag(a.id, 1) over win = 1, 0, 1) as incr
    from stadium a
    where a.people >= 100
    window win as (order by a.visit_date)
),
grpd as (
    select
        a.*,
        sum(a.incr) over win as grp
    from cte a
    window win as (order by a.visit_date rows between unbounded preceding and current row)
)

select 
    a.id,
    a.visit_date,
    a.people
from grpd a
where a.grp in(select grp from grpd group by 1 having count(1) >= 3)
order by a.visit_date;