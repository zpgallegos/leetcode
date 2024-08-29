-- https://leetcode.com/problems/order-two-columns-independently/description/

with a as (
    select
        row_number() over(order by first_col) as idx,
        first_col
    from data
),
b as (
    select
        row_number() over(order by second_col desc) as idx,
        second_col
    from data
)

select a.first_col, b.second_col
from a inner join b on a.idx = b.idx