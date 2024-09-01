-- https://leetcode.com/problems/immediate-food-delivery-ii/description/


with cte as (
    select
        a.*,
        if(a.order_date = a.customer_pref_delivery_date, 1, 0) as is_immediate,
        row_number() over win as rn
    from delivery a
    window win as (partition by a.customer_id order by a.order_date)
)

select round(avg(is_immediate) * 100, 2) as immediate_percentage
from cte
where rn = 1;