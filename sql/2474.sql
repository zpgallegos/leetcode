-- https://leetcode.com/problems/customers-with-strictly-increasing-purchases/

with recursive tbl as (
    select *, year(order_date) as order_year
    from orders
),
years as (
    select min(order_year) as order_year
    from tbl
    
    union all
    
    select order_year + 1
    from years
    where order_year < (select max(order_year) from tbl)
),
bounds as (
    select
        customer_id,
        min(order_year) as customer_min_year,
        max(order_year) as customer_max_year
    from tbl
    group by customer_id
),
ids as (
    select
        bounds.customer_id,
        years.order_year
    from bounds cross join years
    where
        years.order_year >= bounds.customer_min_year and
        years.order_year <= bounds.customer_max_year
),
counts as (
    select
        customer_id,
        order_year,
        sum(tbl.price) as order_count
    from tbl
    group by
        customer_id,
        order_year
),
filled as (
    select * from counts
    
    union
    
    select i.*, 0 as order_count
    from ids i
        left join counts c on i.customer_id = c.customer_id and i.order_year = c.order_year
    where c.customer_id is null
),
lagged as (
    select
        *,
        lag(order_count) over win as lag_count
    from filled
    window win as(partition by customer_id order by order_year)
)

select distinct customer_id
from lagged
group by customer_id
having avg(if(lag_count is null or order_count > lag_count, 1, 0)) = 1;


-- alt

with tbl as (
    select *, year(order_date) as order_year
    from orders
),
t1 as (
    select
        *,
        order_year - lag(order_year) over(partition by customer_id order by order_year asc) as year_diff
    from tbl
),
t2 as (
    select
        *,
        order_year
    from t1
    where customer_id not in(select distinct customer_id from t1 where year_diff > 1)
),
t3 as (
    select
        customer_id,
        order_year,
        sum(price)
    from t2
    group by
        customer_id,
        order_year
)



WITH T1 AS (SELECT *,EXTRACT(Year FROM order_date) - LAG(EXTRACT(Year FROM order_date)) OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS year_diff FROM Orders),
T2 AS (SELECT *,EXTRACT(Year FROM order_date) AS yr FROM T1 WHERE customer_id NOT IN (SELECT DISTINCT customer_id  FROM T1 WHERE year_diff>1)),
T3 AS (SELECT customer_id, yr, SUM(price) AS price  FROM T2 GROUP BY customer_id, yr),
T4 AS (SELECT *, price - LAG(price) OVER(PARTITION BY customer_id ORDER BY yr ASC) AS price_diff FROM T3)



SELECT DISTINCT customer_id  FROM T4
WHERE customer_id NOT IN (SELECT DISTINCT customer_id  FROM T4 WHERE price_diff<=0)