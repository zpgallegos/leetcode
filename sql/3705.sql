-- https://leetcode.com/problems/find-golden-hour-customers/

with stats as (
    select
        customer_id,
        count(1) as total_orders,
        count(1) filter(
            where
                order_timestamp::time between time '11:00' and time '14:00'
                or order_timestamp::time between time '18:00' and time '21:00'
        ) as peak_orders,
        count(order_rating) as rated_orders,
        avg(order_rating) as avg_rating
    from restaurant_orders
    group by 1
)

select
    customer_id,
    total_orders,
    round(peak_orders::numeric / total_orders, 2) * 100 as peak_hour_percentage,
    round(avg_rating, 2) as average_rating
from stats
where
    1=1
    and total_orders >= 3
    and peak_orders::numeric / total_orders >= .6
    and rated_orders::numeric / total_orders >= .5
    and avg_rating >= 4
order by 4 desc, 1 desc;