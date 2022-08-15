-- https://leetcode.com/problems/countries-you-can-safely-invest-in/

with persons as (
    select *, substring(phone_number, 1, 3) as country_code
    from Person
),
all_calls as (
    select caller_id as id, duration
    from Calls
    union all
    select callee_id as id, duration
    from Calls
)

select b.name as country
from persons p
    inner join Country b on p.country_code = b.country_code
    inner join all_calls c on p.id = c.id
group by b.name
having avg(c.duration) > (select avg(duration) from all_calls);