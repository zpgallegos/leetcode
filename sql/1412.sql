-- https://leetcode.com/problems/find-the-quiet-students-in-all-exams/


with cte as (
    select
        *,
        min(score) over win as min_score,
        max(score) over win as max_score
    from exam
    window win as (partition by exam_id)
),
quiet as (
    select student_id
    from cte
    group by student_id
    having sum(case when score = min_score or score = max_score then 1 else 0 end) = 0
)

select
    a.student_id,
    b.student_name
from quiet a
    inner join student b on a.student_id = b.student_id;