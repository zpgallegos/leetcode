-- https://leetcode.com/problems/product-sales-analysis-v/description/

select * from (
    select
        a.user_id,
        sum(a.quantity * b.price) as spending
    from sales a
        inner join product b on a.product_id = b.product_id
    group by a.user_id
) sub order by spending desc, user_id;




