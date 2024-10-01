-- https://leetcode.com/problems/find-top-performing-driver/

with cte as (
    select
        a.driver_id,
        a.accidents,
        b.fuel_type,
        round(avg(c.rating), 2) as rating,
        sum(c.distance) as distance
    from drivers a
        inner join vehicles b on a.driver_id = b.driver_id
        inner join trips c on b.vehicle_id = c.vehicle_id
    group by 1, 2, 3
),
rnked as (
    select
        a.*,
        rank() over win as rnk
    from cte a
    window win as (partition by a.fuel_type order by a.rating desc, a.distance desc, a.accidents desc)
)

select fuel_type, driver_id, rating, distance
from rnked
where rnk = 1
order by 1;