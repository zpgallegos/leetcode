-- https://leetcode.com/problems/students-and-examinations/description/

select
    a.student_id,
    a.student_name,
    b.subject_name,
    count(c.subject_name) as attended_exams
from students a
    cross join subjects b
    left join examinations c on a.student_id = c.student_id and b.subject_name = c.subject_name
group by 1, 2, 3
order by 1, 2;

-- another way

with combs as (
    select 
        a.student_id,
        a.student_name,
        b.subject_name
    from students a cross join subjects b
),
cnts as (
    select
        a.student_id,
        b.student_name,
        a.subject_name,
        count(1) as attended_exams
    from examinations a
        inner join students b on a.student_id = b.student_id
    group by 1, 2, 3
),
res as (

    select * from cnts

    union

    select a.*, 0
    from combs a
        left join cnts b on a.student_id = b.student_id and a.subject_name = b.subject_name
    where b.attended_exams is null
)

select * from res order by 1, 2;

-- nevermind lol