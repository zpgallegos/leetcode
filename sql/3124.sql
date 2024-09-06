-- https://leetcode.com/problems/find-longest-calls/description/


with cte as (
    select
        a.*,
        a.duration / 3600 as hrs,
        (a.duration % 3600) / 60 as mins,
        (a.duration % 60) as secs,
        row_number() over win as rn
    from calls a
    window win as (partition by a.type order by a.duration desc)
)

select
    b.first_name,
    a.type,
    lpad(a.hrs::text, 2, '0') || ':' || 
        lpad(a.mins::text, 2, '0') || ':' || 
        lpad(a.secs::text, 2, '0') as duration_formatted
from cte a
    inner join contacts b on a.contact_id = b.id
where rn <= 3
order by 2 desc, 3 desc, 1 desc;
