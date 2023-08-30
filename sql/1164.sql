-- https://leetcode.com/problems/product-price-at-a-given-date/

with mx as (
    select product_id, max(change_date) as mx
    from Products
    where change_date <= '2019-08-16'
    group by product_id
), changed as (
    select
        a.product_id,
        a.new_price as price
    from Products a 
        inner join mx b on a.product_id = b.product_id and a.change_date = b.mx
)

select * from changed union
    select distinct product_id, 10 as price
    from Products
    where product_id not in(select product_id from changed);


