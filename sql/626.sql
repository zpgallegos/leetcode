-- https://leetcode.com/problems/exchange-seats/description/


with cte as (
    select
        a.*,
        if(a.id % 2 = 0, a.id - 1, a.id + 1) as jkey
    from seat a
)

select
    a.id,
    coalesce(b.student, a.student) as student
from seat a
    left join cte b on a.id = b.jkey
order by 1;