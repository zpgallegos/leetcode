-- https://leetcode.com/problems/find-top-scoring-students-ii/description/


with req_cnts as (
    select
        a.major,
        count(distinct a.course_id) as req_cnt
    from courses a
    where a.mandatory = 'yes'
    group by a.major
),
cte as (
    select
        b.student_id,
        a.major,
        if(a.major = c.major, 1, 0) as is_major,
        if(a.major = c.major and c.mandatory = 'yes', 1, 0) as is_mandatory,
        if(b.grade = 'A', 1, 0) as is_a,
        if(b.grade in('A', 'B'), 1, 0) as is_ab,
        b.gpa
    from students a
        inner join enrollments b on a.student_id = b.student_id
        inner join courses c on b.course_id = c.course_id
),
taken as (
    select sub.student_id
    from (
        select
            a.student_id,
            a.major,
            sum(a.is_mandatory) as mandatory_taken,
            sum(1 - a.is_mandatory) as elective_taken
        from cte a
        where a.is_major = 1
        group by a.student_id
    ) sub inner join req_cnts b on sub.major = b.major
    where
        sub.mandatory_taken = b.req_cnt and
        sub.elective_taken >= 2
),
grades as (
    select a.student_id
    from cte a
    where 
        1=1
        and a.student_id in (select student_id from taken)
    group by a.student_id
    having
        1=1
        and sum(if(a.is_major and a.is_mandatory and not a.is_a, 1, 0)) = 0
        and sum(if(a.is_major and not a.is_mandatory and not a.is_ab, 1, 0)) = 0
),
gpa as (
    select a.student_id
    from cte a
    where student_id in (select student_id from grades)
    group by a.student_id
    having avg(a.gpa) >= 2.5
)

select * from gpa order by student_id;
