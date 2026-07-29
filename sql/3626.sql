-- https://leetcode.com/problems/find-stores-with-inventory-imbalance/description/


with qual as (
    select store_id, count(1) as product_count
    from inventory
    group by 1
    having count(1) >= 3
),

ordered as (
    select
        a.store_id,
        a.product_name,
        a.quantity,
        b.product_count,
        row_number() over win as rn
    from inventory a
    inner join qual b on a.store_id = b.store_id
    window win as (partition by a.store_id order by a.price)
)

select
    a.store_id,
    d.store_name,
    d.location,
    b.product_name as most_exp_product,
    a.product_name as cheapest_product,
    round(a.quantity::numeric / b.quantity, 2) as imbalance_ratio

from ordered a
inner join ordered b on a.store_id = b.store_id and a.rn = 1 and b.rn = a.product_count
inner join stores d on a.store_id = d.store_id

where b.quantity < a.quantity

order by 6 desc, 2;
