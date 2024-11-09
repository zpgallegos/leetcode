-- https://leetcode.com/problems/calculate-special-bonus/description/


select
    a.employee_id,
    case
    when mod(a.employee_id, 2) = 1 and substring(a.name, 1, 1) != 'M' then a.salary
    else 0
    end as bonus
from employees a
order by 1;