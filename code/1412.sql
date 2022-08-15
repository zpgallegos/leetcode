

with cte as (
    select
        *,
        if(
            score = max(score) over(partition by exam_id) or
            score = min(score) over(partition by exam_id), 1, 0
        ) as is_ext
    from Exam
)

select *
from Student a
where 
    student_id not in(select student_id from cte where is_ext) and
    student_id in(select student_id from cte);