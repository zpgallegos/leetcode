
with max_grade as (
    select
        *,
        row_number() over(partition by student_id order by grade desc, course_id) as rw
    
    from Enrollments
)

select student_id, course_id, grade
from max_grade
where rw = 1;