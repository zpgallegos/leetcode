-- https://leetcode.com/problems/consecutive-numbers/

with cte as (
    select
        *,
        if(num = lag(num, 1) over(order by id), 0, 1) as is_consecutive
    from Logs
), cte2 as (
    select
        *,
        sum(is_consecutive) over(order by id) as grp
    from cte
)

select distinct num as ConsecutiveNums
from cte2
group by grp
having count(1) >= 3;
