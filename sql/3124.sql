-- https://leetcode.com/problems/find-longest-calls/


with cte as (
    select
        a.*,
        b.first_name,
        row_number() over(partition by a.type order by a.duration desc) as rn
    from calls a
        inner join contacts b on a.contact_id = b.id
)

select
    first_name,
    type,
    lpad((duration / 3600)::text, 2, '0') || ':' ||
    lpad(((duration % 3600) / 60)::text, 2, '0') || ':' ||
    lpad((duration % 60)::int::text, 2, '0') as duration_formatted
from cte
where rn <= 3
order by 
    type, 
    duration desc,
    first_name desc;
