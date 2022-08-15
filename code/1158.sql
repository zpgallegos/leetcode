

select
    a.user_id as buyer_id,
    a.join_date,
    coalesce(sub.orders, 0) as orders_in_2019

from 
    Users a left join (
        select buyer_id, count(distinct order_id) as orders
        from Orders
        where year(order_date) = 2019
        group by buyer_id
    ) sub on a.user_id = sub.buyer_id



