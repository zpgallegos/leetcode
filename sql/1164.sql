-- https://leetcode.com/problems/product-price-at-a-given-date/description/

with cte as (
    select s.*
    from (
        select
            a.product_id,
            a.new_price as price,
            row_number() over(partition by a.product_id order by a.change_date desc) as rn
        from products a
        where a.change_date <= '2019-08-16'
    ) s
    where s.rn = 1
),
fill as (
    select distinct
        a.product_id,
        10 as price
    from products a
    where a.product_id not in(select product_id from cte)
)

select product_id, price from cte union
select * from fill;

-- https://leetcode.com/problems/product-price-at-a-given-date/description/

with cte as (
    select
        a.product_id,
        b.new_price as price
    from (
        select
            product_id,
            max(change_date) as last_change_date
        from products
        where change_date <= '2019-08-16'
        group by 1
    ) a inner join products b on a.product_id = b.product_id and a.last_change_date = b.change_date
)

select * from cte 

union

select distinct a.product_id, 10 as price 
from products a
where a.product_id not in(select product_id from cte);