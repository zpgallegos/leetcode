-- https://leetcode.com/problems/trips-and-users/solutions/?lang=pythondata

with banned as (
    select users_id
    from Users
    where banned = 'Yes'
),
t as (
    select *, if(status like 'cancelled%', 1, 0) as is_cancelled
    from Trips
    where
        request_at >= '2013-10-01' and
        request_at <= '2013-10-03' and
        client_id not in (select users_id from banned) and
        driver_id not in (select users_id from banned)
)

select
    request_at as "Day",
    round(avg(is_cancelled), 2) as "Cancellation Rate"
from t
group by request_at;