-- https://leetcode.com/problems/sales-by-day-of-the-week/

with all_days as (
    select "Monday" as day_name union
    select "Tuesday" as day_name union
    select "Wednesday" as day_name union
    select "Thursday" as day_name union
    select "Friday" as day_name union
    select "Saturday" as day_name union
    select "Sunday" as day_name
),
mdx as (
    select
        a.item_category as Category,
        b.day_name
    from items a cross join all_days b
),
cte as (
    select
        b.item_category as Category,
        dayname(a.order_date) as day_name,
        sum(a.quantity) as cnt
    from orders a
        inner join items b on a.item_id = b.item_id
    group by 1, 2
),
filled as (
    select * from cte

    union

    select
        a.*,
        0 as cnt
    from mdx a
        left join cte b on a.Category = b.Category and a.day_name = b.day_name
    where b.Category is null
)


select
    a.Category,
    max(case when a.day_name = "Monday" then a.cnt else 0 end) as Monday,
    max(case when a.day_name = "Tuesday" then a.cnt else 0 end) as Tuesday,
    max(case when a.day_name = "Wednesday" then a.cnt else 0 end) as Wednesday,
    max(case when a.day_name = "Thursday" then a.cnt else 0 end) as Thursday,
    max(case when a.day_name = "Friday" then a.cnt else 0 end) as Friday,
    max(case when a.day_name = "Saturday" then a.cnt else 0 end) as Saturday,
    max(case when a.day_name = "Sunday" then a.cnt else 0 end) as Sunday
from filled a
group by 1
order by 1;
