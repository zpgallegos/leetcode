-- https://leetcode.com/problems/consecutive-numbers/description/

with cte as (
    select
        s.*,
        sum(s.incr) over(order by s.id) as grp
    from (
        select
            a.*,
            if(a.num != lag(a.num, 1) over win or a.id - 1 != lag(a.id, 1) over win, 1, 0) as incr
        from logs a
        window win as (order by a.id)
    ) s
)

select distinct num as ConsecutiveNums
from cte
group by num, grp
having count(1) >= 3;