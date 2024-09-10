-- https://leetcode.com/problems/total-traveled-distance/description/

with cte as (
    select
        a.user_id,
        sum(a.distance) as dist
    from rides a
        inner join users b on a.user_id = b.user_id
    group by 1
)

select
    a.user_id,
    a.name,
    coalesce(b.dist, 0) as "traveled distance"
from users a
    left join cte b on a.user_id = b.user_id
order by 1;