-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/


select
    b.unique_id,
    a.name
from employees a
    left join employeeuni b on a.id = b.id;