-- https://leetcode.com/problems/product-price-at-a-given-date/

declare @before date = '2019-08-16';

with all_prods as (
    select distinct product_id from products
), lst as (
    select product_id, max(change_date) as last_change
    from products
    where change_date <= @before
    group by product_id
), res as (
    select a.product_id, a.new_price as price
    from products a
        inner join lst b on a.product_id = b.product_id and a.change_date = b.last_change
)

select * from res union
select product_id, 10 as price from all_prods where product_id not in(select product_id from res);

