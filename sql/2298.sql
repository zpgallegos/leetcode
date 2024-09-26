-- https://leetcode.com/problems/tasks-count-in-the-weekend/description/

with cte as (
    select 
        case
        when extract(dow from a.submit_date) in(0, 6) then 1
        else 0
        end as is_weekend
    from tasks a
)

select
    sum(is_weekend) as weekend_cnt,
    sum(1 - is_weekend) as working_cnt
from cte;