-- https://leetcode.com/problems/project-employees-iii/


select project_id, employee_id
from (
    select
        a.project_id,
        a.employee_id,
        rank() over(partition by a.project_id order by b.experience_years desc) as rnk
    from Project a inner join Employee b on a.employee_id = b.employee_id
) s where rnk = 1
