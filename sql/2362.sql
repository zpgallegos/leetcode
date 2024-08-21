-- https://leetcode.com/problems/generate-the-invoice/

with cte as (
    select
        sub.invoice_id,
        row_number() over win as rn
    from (
        select
            a.invoice_id,
            sum(a.quantity * b.price) as invoice_total
        from purchases a
            inner join products b on a.product_id = b.product_id
        group by 1
    ) sub
    window win as (order by sub.invoice_total desc, sub.invoice_id)
)

select
    a.product_id,
    a.quantity,
    sum(a.quantity * b.price) as price
from purchases a
    inner join products b on a.product_id = b.product_id
where a.invoice_id = (select invoice_id from cte where rn = 1)
group by 1, 2;
