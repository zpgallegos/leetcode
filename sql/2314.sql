-- https://leetcode.com/problems/the-first-day-of-the-maximum-recorded-degree-in-each-city/description/

with cte as (
    select
        a.*,
        row_number() over win as rnk
    from weather a
    window win as (partition by a.city_id order by a.degree desc, a.day)
)

select a.city_id, a.day, a.degree
from cte a
where a.rnk = 1
order by 1;