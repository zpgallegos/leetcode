-- https://leetcode.com/problems/the-number-of-passengers-in-each-bus-ii/


with recursive bus as (
    select
        bus_id,
        row_number() over(order by a.arrival_time) as bus_n,
        a.arrival_time,
        lag(a.arrival_time, 1, 0) over(order by a.arrival_time) as last_bus_arrival_time,
        a.capacity
    from buses a
),
new as (
    select
        a.bus_id,
        a.bus_n,
        a.capacity,
        count(b.passenger_id) as pass_cnt
    from bus a
        left join passengers b on
            b.arrival_time <= a.arrival_time and
            b.arrival_time > a.last_bus_arrival_time
    group by 1, 2, 3
),
cte as (
    select
        a.bus_id,
        a.bus_n,
        if(a.pass_cnt >= a.capacity, a.capacity, a.pass_cnt) as picked_up,
        if(a.pass_cnt > a.capacity, a.pass_cnt - a.capacity, 0) as waiting
    from new a
    where a.bus_n = 1
    
    union all
    
    select
        b.bus_id,
        b.bus_n,
        if(b.pass_cnt + a.waiting >= b.capacity, b.capacity, b.pass_cnt + a.waiting) as picked_up,
        if(b.pass_cnt + a.waiting > b.capacity, b.pass_cnt + a.waiting - b.capacity, 0) as waiting
    from cte a
        inner join new b on a.bus_n + 1 = b.bus_n
)

select a.bus_id, a.picked_up as passengers_cnt
from cte a
order by a.bus_id;