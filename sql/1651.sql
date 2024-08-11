-- https://leetcode.com/problems/hopper-company-queries-iii/description/

with recursive all_months as (
    select 1 as month union all
    select a.month + 1 from all_months a where a.month < 12
),
agg_stg as (
    select
        month(a.requested_at) as month,
        sum(b.ride_distance) as total_dist,
        sum(b.ride_duration) as total_duration
    from rides a
        inner join acceptedrides b on a.ride_id = b.ride_id
    where a.requested_at between '2020-01-01' and '2020-12-31'
    group by 1
),
agg as (
    select * from agg_stg
    
    union
    
    select
        a.month,
        0 as total_dist,
        0 as total_duration
    from all_months a
    where a.month not in(select a.month from agg_stg a)
),
roll as (
    select
        a.month,
        sum(total_dist) over win as dist,
        sum(total_duration) over win as dur
    from agg a
    window win as (order by a.month rows between 2 preceding and current row)
)

select
    a.month - 2 as month,
    round(a.dist / 3, 2) as average_ride_distance,
    round(a.dur / 3, 2) as average_ride_duration
from roll a
where a.month > 2;