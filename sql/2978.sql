-- https://leetcode.com/problems/symmetric-coordinates/description/

with cte as (
    select *, row_number() over(order by x, y) as rw
    from coordinates
)

select distinct a.x, a.y
from cte a inner join cte b on a.x = b.y and a.y = b.x and a.rw < b.rw
order by a.x, a.y;