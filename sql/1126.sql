-- https://leetcode.com/problems/active-businesses/


with avgs as (
    select event_type, avg(occurences) as event_avg
    from Events
    group by event_type
)

select business_id
from Events a inner join avgs b on a.event_type = b.event_type
group by business_id
having sum(a.occurences > b.event_avg) > 1;