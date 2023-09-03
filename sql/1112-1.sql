-- https://leetcode.com/problems/highest-grade-for-each-student/submissions/?lang=pythondata

select
    student_id,
    course_id,
    grade

from (
    select
        *,
        row_number() over win as rw
    from enrollments
    window win as (partition by student_id order by grade desc, course_id)
) s

where s.rw = 1
order by student_id;