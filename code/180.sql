select distinct sub.num as ConsecutiveNums
from (
    select
        id,
        num,
        lag(id, 1) over(partition by num order by id) as lag_1,
        lag(id, 2) over(partition by num order by id) as lag_2

    from Logs
) sub
where sub.id - 1 = lag_1 and sub.id - 2 = lag_2;


select distinct num as ConsecutiveNums
from Logs
where (id - 1, num) in (select * from Logs) and (id - 2, num) in (select * from Logs)