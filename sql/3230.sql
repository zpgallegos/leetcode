-- https://leetcode.com/problems/customer-purchasing-behavior-analysis/description/

with src as (
    select
        a.*,
        b.category,
        count(1) over(partition by a.customer_id, b.category) as cat_cnt
    from transactions a
        inner join products b on a.product_id = b.product_id
),
cte as (
    select
        a.*,
        row_number() over(partition by a.customer_id order by a.cat_cnt desc, a.transaction_date desc) as cat_rnk
    from src a
),
agg as (
    select
        a.customer_id,
        round(sum(a.amount), 2) as total_amount,
        count(1) as transaction_count,
        count(distinct a.category) as unique_categories,
        round(avg(a.amount), 2) as avg_transaction_amount
    from cte a
    group by a.customer_id
),
fav_cat as(
    select a.customer_id, a.category
    from cte a
    where a.cat_rnk = 1
)

select
    a.*,
    b.category as top_category,
    round((a.transaction_count * 10) + (a.total_amount / 100), 2) as loyalty_score
from agg a
    inner join fav_cat b on a.customer_id = b.customer_id
order by loyalty_score desc, a.customer_id;



