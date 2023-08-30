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

select distinct num
from logs
where 
    (id + 1, num) in (select * from logs) and 
    (id + 1, num) in (select * from logs);


-- solved generally

with cte as (
    select
        *,
        if(num = lag(num, 1) over(order by id), 0, 1) as chg -- 1 when the number changes
    from logs
), cte2 as (
    select
        *,
        sum(chg) over(order by id) as grp -- window sum to identify groups of consecutives
    from cte
)

select distinct num as ConsecutiveNums
from cte2
group by grp
having count(1) >= 3;