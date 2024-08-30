-- https://leetcode.com/problems/rising-temperature/description/

with cte as (
    select
        a.*,
        lag(a.recorddate, 1) over win as last_date,
        lag(a.temperature, 1) over win as last_temp
    from weather a
    window win as (order by a.recorddate)
)

select id
from cte
where 
    1=1
    and datediff(recorddate, last_date) = 1
    and temperature > last_temp;
