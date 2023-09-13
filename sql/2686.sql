-- https://leetcode.com/problems/immediate-food-delivery-iii/

select * from (
    select
        order_date,
        round(avg(if(order_date = customer_pref_delivery_date, 1, 0)) * 100, 2) as immediate_percentage
    from delivery
    group by order_date
) s order by order_date;