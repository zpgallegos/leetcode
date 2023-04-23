-- https://leetcode.com/problems/exchange-seats/

with cte as (
    select
        *,
        case
        when mod(id, 2) = 0 then id - 1
        else id + 1
        end as join_id
    
    from seat
)

select
    a.id,
    coalesce(b.student, a.student) as student

from
    cte a left join cte b on a.id = b.join_id;