-- https://leetcode.com/problems/the-airport-with-the-most-traffic/

with cte as (
    select
        a.airport_id,
        sum(a.flights_count) as cnt
    from (
        select departure_airport as airport_id, flights_count from flights union all
        select arrival_airport as airport_id, flights_count from flights
    ) a
    group by 1
)

select a.airport_id
from cte a 
where a.cnt = (select max(a.cnt) from cte a);