-- https://leetcode.com/problems/consecutive-numbers/

-- using lags

with cte as (
    select
        num,
        lag(num, 1) over(order by id) as num_1,
        lag(num, 2) over(order by id) as num_2
    from logs
)

select distinct num as ConsecutiveNums
from cte
where num = num_1 and num = num_2;

-- using subqueries in the where

select distinct num as ConsecutiveNums
from logs
where 
    (id + 1, num) in (select * from logs) and 
    (id + 1, num) in (select * from logs);


-- solved generally

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

-- T-SQL, general

declare @minConsecutive int = 3;

with cte as (
    select
        *,
        case when num = lag(num, 1) over(order by id) then 0 else 1 end as chg
    from logs
), cte1 as (
    select
        *,
        sum(chg) over(order by id) as grp
    from cte
)

select distinct num as ConsecutiveNums
from cte1
group by grp, num
having count(1) >= @minConsecutive;