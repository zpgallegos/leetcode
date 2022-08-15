-- https://leetcode.com/problems/the-most-frequently-ordered-products-for-each-customer/


select customer_id, product_id, product_name from (
    select
        a.customer_id,
        a.product_id,
        b.product_name,
        rank() over(partition by a.customer_id order by a.cnt desc) as rnk

    from (
        select customer_id, product_id, count(1) as cnt
        from Orders
        group by customer_id, product_id
    ) a inner join Products b on a.product_id = b.product_id
) s where rnk = 1;
