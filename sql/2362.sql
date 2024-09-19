-- https://leetcode.com/problems/generate-the-invoice/

with cte as (
    select
        a.invoice_id,
        b.product_id,
        a.quantity,
        a.quantity * b.price as price
    from purchases a
        inner join products b on a.product_id = b.product_id
),
tab as (
    select invoice_id, sum(price) as price
    from cte
    group by 1
),
rnkd as (
    select
        invoice_id,
        rank() over win as rnk
    from tab
    window win as (order by price desc, invoice_id)
)

select product_id, quantity, price
from cte
where invoice_id = (select invoice_id from rnkd where rnk = 1);