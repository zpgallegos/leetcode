-- https://leetcode.com/problems/group-employees-of-the-same-salary/description/

with cte as (
    select
        a.*,
        count(1) over win as sal_cnt
    from employees a
    window win as (partition by a.salary)
)

select 
    a.employee_id, 
    a.name, 
    a.salary, 
    dense_rank() over win as team_id
from cte a
where a.sal_cnt > 1
window win as (order by a.salary)
order by 4, 1;

-- probably better....

select
    a.*,
    dense_rank() over win as team_id
from employees a
where a.salary in(
    select salary 
    from employees
    group by 1
    having count(1) > 1
)
window win as (order by a.salary)
order by team_id, employee_id;