-- https://leetcode.com/problems/the-number-of-passengers-in-each-bus-ii/description/

with recursive bus as (
    select 
        a.*,
        row_number() over win as bus_idx,
        lag(a.arrival_time, 1, 0) over win as last_arrival
    from buses a
    window win as (order by a.arrival_time)
),
cte as (
    select
        a.bus_idx,
        a.bus_id,
        a.capacity,
        count(b.passenger_id) as since_last    
    from bus a left join passengers b on -- left for since_last=0 when no new passengers arrive for a bus
        1=1
        and b.arrival_time > a.last_arrival 
        and b.arrival_time <= a.arrival_time
    group by 1, 2, 3
),
taken as (
    select
        a.bus_idx,
        a.bus_id,
        case when a.since_last >= a.capacity then a.capacity else a.since_last end as picked_up,
        case when a.since_last > a.capacity then a.since_last - a.capacity else 0 end as waiting
    from cte a
    where a.bus_idx = 1

    union

    select
        a.bus_idx,
        a.bus_id,
        case when a.since_last + b.waiting >= a.capacity then a.capacity else a.since_last + b.waiting end,
        case when a.since_last + b.waiting > a.capacity then a.since_last + b.waiting - a.capacity else 0 end
    from cte a
        inner join taken b on a.bus_idx = b.bus_idx + 1
)

select bus_id, picked_up as passengers_cnt
from taken
order by 1;