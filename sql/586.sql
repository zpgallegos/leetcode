select
    sub.customer_number
from
    (
        select
            customer_number,
            count(distinct order_number) as cnt
        from
            Orders
        group by
            customer_number
    ) sub
order by
    sub.cnt desc
limit
    1;