-- https://leetcode.com/problems/find-peak-calling-hours-for-each-city/description/

with cte as (
    select
        city,
        hour(call_time) as hr,
        count(1) as number_of_calls
    from calls
    group by 1, 2
),
mx as (
    select
        city,
        max(number_of_calls) as max_calls
    from cte
    group by 1
)

select
    a.city,
    a.hr as peak_calling_hour,
    a.number_of_calls
from cte a
    inner join mx b on a.city = b.city and a.number_of_calls = b.max_calls
order by 2 desc, 1 desc;


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