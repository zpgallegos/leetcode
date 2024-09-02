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


-- this was a lazy ass re-do, fuck this annoying ass problem


with cte as (
    select
        a.*,
        b.category
    from transactions a
        inner join products b on a.product_id = b.product_id
),
cats as (
    select
        s.customer_id,
        s.category,
        row_number() over win as cat_rnk
    from (
        select
            a.customer_id,
            a.category,
            count(1) as cat_cnt,
            max(a.transaction_date) as last_transaction
        from cte a
        group by 1, 2
    ) s
    window win as (partition by s.customer_id order by s.cat_cnt desc, s.last_transaction desc)
)

select
    a.customer_id,
    round(sum(a.amount), 2) as total_amount,
    count(1) as transaction_count,
    count(distinct a.category) as unique_categories,
    round(avg(a.amount), 2) as avg_transaction_amount,
    b.category as top_category,
    round((count(1) * 10) + (sum(a.amount) / 100), 2) as loyalty_score
from cte a
    inner join cats b on a.customer_id = b.customer_id
where b.cat_rnk = 1
group by 1, 6
order by 7 desc, 1;
