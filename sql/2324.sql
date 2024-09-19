-- https://leetcode.com/problems/product-sales-analysis-iv/

with cte as (
    select
        a.user_id,
        a.product_id,
        sum(a.quantity * b.price) as spent
    from sales a
        inner join product b on a.product_id = b.product_id
    group by 1, 2
),
tabd as (
    select
        a.*,
        rank() over win as rnk
    from cte a
    window win as (partition by a.user_id order by a.spent desc)
)

select user_id, product_id
from tabd
where rnk = 1;