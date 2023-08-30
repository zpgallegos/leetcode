-- https://leetcode.com/problems/find-cutoff-score-for-each-school/


with reg as (
    select
        a.school_id,
        min(b.score) as score
    from Schools a cross join Exam b
    where b.student_count <= a.capacity
    group by a.school_id
)

select * from reg
union all
select school_id, -1 as score
from Schools
where school_id not in(select school_id from reg);