-- https://leetcode.com/problems/sales-by-day-of-the-week/

with recursive weekdays as (
    select 0 as day_int
    union
    select day_int + 1 from weekdays where day_int < 6
),
cats as (
    select 
        b.item_category, 
        case a.day_int
        when 0 then 'Monday'
        when 1 then 'Tuesday'
        when 2 then 'Wednesday'
        when 3 then 'Thursday'
        when 4 then 'Friday'
        when 5 then 'Saturday'
        when 6 then 'Sunday'
        end as wkday
    from weekdays a cross join items b
),
counts as (
    select
        b.item_category,
        dayname(a.order_date) as wkday,
        sum(a.quantity) as cnt
    from orders a inner join items b on a.item_id = b.item_id
    group by
        b.item_category, 
        dayname(a.order_date)
),
all_counts as (
    select * from counts

    union

    select a.*, 0 as cnt
    from cats a
        left join counts b on a.item_category = b.item_category and a.wkday = b.wkday
    where b.wkday is null
)

select * from (
    select
        item_category as Category,
        max(case when wkday = 'Monday' then cnt else 0 end) as 'Monday',
        max(case when wkday = 'Tuesday' then cnt else 0 end) as 'Tuesday',
        max(case when wkday = 'Wednesday' then cnt else 0 end) as 'Wednesday',
        max(case when wkday = 'Thursday' then cnt else 0 end) as 'Thursday',
        max(case when wkday = 'Friday' then cnt else 0 end) as 'Friday',
        max(case when wkday = 'Saturday' then cnt else 0 end) as 'Saturday',
        max(case when wkday = 'Sunday' then cnt else 0 end) as 'Sunday'
    from all_counts
    group by item_category
) q order by Category;