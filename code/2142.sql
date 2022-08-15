-- https://leetcode.com/problems/the-number-of-passengers-in-each-bus-i/

with cte as (
    select
        bus_id,
        arrival_time as bus_time,
        coalesce(lag(arrival_time, 1) over(order by arrival_time), 0) as last_bus
    from buses
)

select * from (
    select bus_id, count(b.passenger_id) as passengers_cnt
    from cte a 
        left join Passengers b on b.arrival_time > a.last_bus and b.arrival_time <= a.bus_time
    group by bus_id
) s order by bus_id;