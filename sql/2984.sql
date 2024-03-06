-- https://leetcode.com/problems/find-peak-calling-hours-for-each-city/

with cte as (
    select *, datepart(hour, call_time) as call_hour
    from calls
), grpd as (
    select
        city, 
        call_hour,
        count(1) as calls
    from cte
    group by city, call_hour
), rnkd as (
    -- optional, using window function
    select
        *,
        rank() over(partition by city order by calls desc) as rnk
    from grpd
)

-- window function way
select
    city,
    call_hour as peak_calling_hour,
    calls as number_of_calls
from rnkd
where rnk = 1
order by call_hour desc, city desc;

-- other way
select
    a.city,
    a.call_hour as peak_calling_hour,
    a.calls as number_of_calls

from grpd a
    inner join (
        select city, max(calls) as mx
        from grpd
        group by city
    ) sub on a.city = sub.city and a.calls = sub.mx

order by a.call_hour desc, a.city desc;