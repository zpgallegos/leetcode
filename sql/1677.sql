-- https://leetcode.com/problems/products-worth-over-invoices/

with cte as (
    select
        prd.name,
        sum(inv.rest) as rest,
        sum(inv.paid) as paid,
        sum(inv.canceled) as canceled,
        sum(inv.refunded) as refunded

    from invoice inv
        inner join product prd on inv.product_id = prd.product_id

    group by 1
), missing as (
    select p.name, 0 as rest, 0 as paid, 0 as canceled, 0 as refunded
    from product p
    where p.name not in(select cte.name from cte)
)

select * from (
    select * from cte union
    select * from missing
) s order by s.name;