-- https://leetcode.com/problems/find-cumulative-salary-of-an-employee/

with base as (
    select a.*
    from employee a
        inner join (
            select id, max(month) as max_month
            from employee
            group by id
        ) b on a.id = b.id and a.month < b.max_month
), cte as (
    select
        *,
        lag(month, 1) over win as month_1,
        lag(month, 2) over win as month_2,
        lag(salary, 1) over win as salary_1,
        lag(salary, 2) over win as salary_2
    from base
    window win as (partition by id order by month)
)

select
    id,
    month,
    salary + 
        if(month_1 = month - 1, salary_1, 0) + 
        if(month_2 = month - 2, salary_2, 0) as salary
from cte
order by id, month desc