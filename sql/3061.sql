-- https://leetcode.com/problems/calculate-trapping-rain-water/description/

with mx as (
    select
        *,
        coalesce(max(height) over(order by id desc rows between unbounded preceding and 1 preceding), 0) as max_right,
        coalesce(max(height) over(order by id rows between unbounded preceding and 1 preceding), 0) as max_left
    from heights
), calc as (
    select 
        *,
        (case when max_left < max_right then max_left else max_right end) - height as val
    from mx
)

select sum(case when val > 0 then val else 0 end) as total_trapped_water
from calc;