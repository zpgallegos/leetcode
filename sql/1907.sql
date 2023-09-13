-- https://leetcode.com/problems/count-salary-categories/description/?lang=pythondata

with cats as (
    select "Low Salary" as category union
    select "Average Salary" as category union
    select "High Salary" as category
),
tbl as (
    select
        case
        when income < 20000 then "Low Salary"
        when income <= 50000 then "Average Salary"
        else "High Salary"
        end as category
    from accounts
),
cnts as (
    select category, count(1) as cnt
    from tbl
    group by category
)

select
    cats.category,
    coalesce(cnts.cnt, 0) as "accounts_count"
from cats
    left join cnts on cats.category = cnts.category;