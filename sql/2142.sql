-- https://leetcode.com/problems/the-number-of-passengers-in-each-bus-i/

with bus as (
    select
        b.*,
        row_number() over(order by b.arrival_time) as bus_idx
    from buses b
), cte as (
    select
        sub.taken_idx,
        count(1) as passengers_cnt
    from (
        select
            p.passenger_id,
            min(b.bus_idx) as taken_idx
        from passengers p cross join bus b
        where b.arrival_time >= p.arrival_time
        group by 1
    ) sub
    group by 1
)

select
    a.bus_id,
    coalesce(b.passengers_cnt, 0) as passengers_cnt
from bus a
    left join cte b on a.bus_idx = b.taken_idx
order by 1;