-- https://leetcode.com/problems/find-top-scoring-students/description/


with course_counts as (
    select
        major,
        count(distinct course_id) as course_count
    from courses
    group by major
), agg as (
    select
        a.student_id,
        a.major,
        count(distinct c.course_id) as taken
    from students a
        inner join courses b on a.major = b.major
        inner join enrollments c on a.student_id = c.student_id and b.course_id = c.course_id
    group by a.student_id
    having avg(case when c.grade = 'A' then 1 else 0 end) = 1
)

select a.student_id
from agg a
    inner join course_counts b on a.major = b.major
where a.taken = b.course_count
order by a.student_id;
