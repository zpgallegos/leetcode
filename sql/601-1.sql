-- https://leetcode.com/problems/human-traffic-of-stadium/

with cte as (
    select
        *,
        lag(id, 1) over win as last_id,
        lag(people, 1) over win as last_people
    from stadium
    window win as (order by id)
),
incr as (
    select
        *,
        case
        when 
            people < 100
            or last_people < 100
            or last_id <> id - 1
        then 1
        else 0 end as i
    from cte
),
grpd as (
    select *, sum() over(order by id) as grp
    from incr
)

select id, visit_date, people
from grpd
where grp in (
    select grp
    from grpd
    group by grp
    having count(1) >= 3
)
order by visit_date;