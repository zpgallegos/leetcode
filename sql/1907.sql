-- https://leetcode.com/problems/count-salary-categories/description/

with cats as (
    select 'High Salary' as category union
    select 'Average Salary' union
    select 'Low Salary'
),
cnts as (
    select
        case
        when a.income > 50000 then 'High Salary'
        when a.income >= 20000 then 'Average Salary'
        else 'Low Salary'
        end as category,
        count(1) as cnt
    from accounts a
    group by 1
)

select
    a.category,
    coalesce(b.cnt, 0) as accounts_count
from cats a
    left join cnts b on a.category = b.category;
