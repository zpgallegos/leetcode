-- https://leetcode.com/problems/students-with-invalid-departments/description/

select
    a.id,
    a.name
from students a
    left join departments b on a.department_id = b.id
where b.id is null;