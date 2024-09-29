-- https://leetcode.com/problems/order-two-columns-independently/

with frst as (
    select a.first_col, row_number() over(order by a.first_col) as rn
    from data a
),
scnd as (
    select a.second_col, row_number() over(order by a.second_col desc) as rn
    from data a
)

select a.first_col, b.second_col
from frst a inner join scnd b on a.rn = b.rn
order by a.rn;