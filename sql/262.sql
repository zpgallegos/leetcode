-- https://leetcode.com/problems/trips-and-users/description/


with banned as (
    select users_id from users where banned = 'Yes'
)

select 
    a.request_at as Day,
    round(avg(if(a.status like 'cancelled%', 1, 0)), 2) as `Cancellation Rate`
from trips a
where
    1=1
    and a.request_at between '2013-10-01' and '2013-10-03'
    and a.client_id not in(select * from banned)
    and a.driver_id not in(select * from banned)
group by 1;