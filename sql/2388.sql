-- https://leetcode.com/problems/change-null-values-in-a-table-to-the-previous-value/

with cte as (
    select
        a.*,
        row_number() over() as idx
    from coffeeshop a
),
grpd as (
    select
        a.*,
        sum(if(a.drink is not null, 1, 0)) over win as grp
    from cte a
    window win as (order by a.idx rows between unbounded preceding and current row)
)

select
    a.*,
    first_value(a.drink) over(partition by a.grp order by a.idx) as test
from grpd a;