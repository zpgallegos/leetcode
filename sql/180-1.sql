-- https://leetcode.com/problems/consecutive-numbers/

with cte as (
    select
        *,
        if(num != lag(num) over win, 1, 0) as changed
    from logs
    window win as (order by id)
), cume as (
    select
        *,
        sum(changed) over(order by id) as grp
    from cte
)

select distinct num as ConsecutiveNums
from cume
group by num, grp
having count(1) >= 3;