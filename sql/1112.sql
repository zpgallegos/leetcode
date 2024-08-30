-- https://leetcode.com/problems/highest-grade-for-each-student/

with cte as (
    select
        a.*,
        row_number() over win as rn
    from enrollments a
    window win as (partition by a.student_id order by a.grade desc, a.course_id)
)

select
    a.student_id,
    a.course_id,
    a.grade
from cte a
where a.rn = 1
order by 1;