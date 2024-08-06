-- https://leetcode.com/problems/average-salary-departments-vs-company/

with sal as (
    select
        date_format(a.pay_date, '%Y-%m') AS pay_month,
        b.department_id,
        a.amount
    from salary a
        inner join employee b on a.employee_id = b.employee_id
),
month_avg as (
    select pay_month, avg(amount) as month_avg
    from sal
    group by 1
),
dep_avg as (
    select pay_month, department_id, avg(amount) as dep_avg
    from sal
    group by 1, 2
)

select
    a.pay_month,
    a.department_id,
    case
        when a.dep_avg > b.month_avg then 'higher'
        when a.dep_avg = b.month_avg then 'same'
        else 'lower'
    end as comparison
from dep_avg a
    inner join month_avg b on a.pay_month = b.pay_month;