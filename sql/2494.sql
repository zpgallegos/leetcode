-- https://leetcode.com/problems/merge-overlapping-events-in-the-same-hall/

| hall_id | start_day  | end_day    |
| ------- | ---------- | ---------- |
| 2       | 2022-12-08 | 2023-01-04 |
| 2       | 2022-12-09 | 2023-01-05 |
| 2       | 2022-12-13 | 2023-01-26 |
| 2       | 2023-01-04 | 2023-01-15 |
| 2       | 2023-01-20 | 2023-01-22 |
| 3       | 2022-12-10 | 2023-01-26 |
| 3       | 2022-12-04 | 2022-12-09 |
| 3       | 2022-12-14 | 2022-12-22 |
| 3       | 2023-01-05 | 2023-01-21 |
| 3       | 2023-01-13 | 2023-01-31 |

with cte as (
    select
        *,
        if(start_day - lag(end_day) over win > 0, 1, 0) as incr
    from hallevents
    window win as (partition by hall_id order by start_day asc)
), cte1 as (
    select 
        *,
        sum(incr) over win as grp
    from cte
    window win as (partition by hall_id order by start_day rows between unbounded preceding and current row)
)

select * from cte1 order by hall_id, start_day;

select 
    hall_id, 
    min(start_day) as start_day,
    max(end_day) as end_day
from cte1
group by hall_id, grp;