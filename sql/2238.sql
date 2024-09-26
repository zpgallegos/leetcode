-- https://leetcode.com/problems/number-of-times-a-driver-was-a-passenger/description/

with drivers as (
    select distinct driver_id from rides
),
cnts as (
    select passenger_id as driver_id, count(1) as cnt
    from rides
    group by 1
)

select
    a.driver_id,
    coalesce(b.cnt, 0) as cnt
from drivers a
    left join cnts b on a.driver_id = b.driver_id;