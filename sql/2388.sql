-- https://leetcode.com/problems/change-null-values-in-a-table-to-the-previous-value/

with grpd as (
    select
        a.*,
        sum(case when drink is not null then 1 else 0 end) over win as grp
    from coffeeshop a
    window win as (rows between unbounded preceding and current row)
)

select id, first_value(drink) over win as drink
from grpd
window win as (partition by grp);