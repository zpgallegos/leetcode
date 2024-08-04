-- https://leetcode.com/problems/countries-you-can-safely-invest-in/

with cte as (
    select
        sub.id,
        b.name as country
    from (
        select
            a.*,
            substring(a.phone_number, 1, 3) as country_code
        from person a
    ) sub inner join country b on sub.country_code = b.country_code
),
tbl as (
    select b.country, a.duration
    from calls a inner join cte b on a.caller_id = b.id
    union all
    select b.country, a.duration
    from calls a inner join cte b on a.callee_id = b.id
)

select country
from tbl
group by country
having avg(duration) > (select avg(duration) from tbl);