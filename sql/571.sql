-- https://leetcode.com/problems/find-median-given-frequency-of-numbers/

with cte as (
    select
        a.*,
        sum(a.frequency) over win as cum
    from numbers a   
    window win as (order by a.num rows between unbounded preceding and current row)
),
cnt as (
    select max(cum) as N
    from cte a
),
info as (
    select 
        N,
        N / 2 as mid,
        floor(N / 2) + 1 as mid_floor,
        if(mod(N, 2) = 0, true, false) as is_even
    from cnt
),
idxs as (
    select
        case when a.is_even then a.mid else a.mid_floor end as lower,
        case when a.is_even then a.mid + 1 else a.mid_floor end as upper
    from info a
),
lower as (
    select min(a.num) as num
    from cte a
    where a.cum >= (select lower from idxs)
),
upper as (
    select min(a.num) as num
    from cte a
    where a.cum >= (select upper from idxs)
)

select round(avg(a.num), 2) as median
from (
    select num from lower union
    select num from upper
) a;

