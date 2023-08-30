-- https://leetcode.com/problems/flight-occupancy-and-waitlist-analysis/

select
    f.flight_id,
    case
    when cnts.cnt is null then 0
    when cnts.cnt >= f.capacity then f.capacity
    else cnts.cnt
    end as booked_cnt,
    case
    when cnts.cnt is null or cnts.cnt <= f.capacity then 0
    else cnts.cnt - f.capacity
    end as waitlist_cnt
    
from flights f left join (
    select flight_id, count(passenger_id) as cnt
    from passengers
    group by flight_id
    ) cnts on f.flight_id = cnts.flight_id

order by f.flight_id;





