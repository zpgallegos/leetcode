-- https://leetcode.com/problems/immediate-food-delivery-iii/

select
    a.order_date,
    round(avg(case when a.order_date = a.customer_pref_delivery_date then 1 else 0 end) * 100, 2) as immediate_percentage
from delivery a
group by 1
order by 1;
