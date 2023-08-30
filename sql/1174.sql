-- https://leetcode.com/problems/immediate-food-delivery-ii/
SELECT
    round(
        avg(a.order_date = a.customer_pref_delivery_date) * 100,
        2
    ) AS immediate_percentage
FROM
    delivery a
    INNER JOIN (
        SELECT
            customer_id,
            min(order_date) AS first_order_date
        FROM
            Delivery
        GROUP BY
            customer_id
    ) s ON a.customer_id = s.customer_id
    AND a.order_date = s.first_order_date