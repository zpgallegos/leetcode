-- https://leetcode.com/problems/calculate-the-influence-of-each-salesperson/

with totals as (
    select
        b.salesperson_id,
        sum(a.price) as total
    from sales a
        inner join customer b on a.customer_id = b.customer_id
    group by 1
)

select
    a.salesperson_id,
    a.name,
    coalesce(b.total, 0) as total
from salesperson a
    left join totals b on a.salesperson_id = b.salesperson_id;