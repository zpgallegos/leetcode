-- https://leetcode.com/problems/find-top-scoring-students-ii/


with mand_cnts as (
    select a.major, count(1) as mand_cnt
    from courses a
    where a.mandatory = 'yes'
    group by 1
),
cte as (
    select
        a.student_id,
        a.course_id,
        b.major,
        a.gpa,
        if(c.major = b.major, true, false) as in_major,
        if(b.mandatory = 'yes', 1, 0) as is_mandatory,
        if(a.grade = 'A', 1, 0) as is_a,
        if(a.grade in('A', 'B'), 1, 0) as is_ab
    from enrollments a
        inner join courses b on a.course_id = b.course_id
        inner join students c on a.student_id = c.student_id
),
qual as (
    select s.student_id
    from (
        select
            a.student_id,
            a.major,
            sum(a.is_mandatory) as mand_taken,
            sum(1 - a.is_mandatory) as elec_taken,
            avg(case when a.is_mandatory then a.is_a else null end) as mand_gpa_req,
            avg(case when a.is_mandatory then null else a.is_ab end) as elec_gpa_req
        from cte a
        where a.in_major
        group by 1, 2
    ) s
        inner join mand_cnts b on s.major = b.major and s.mand_taken = b.mand_cnt
    where
        1=1
        and s.elec_taken >= 2
        and s.mand_gpa_req = 1
        and s.elec_gpa_req = 1
)

select a.student_id
from cte a
where a.student_id in(select * from qual)
group by 1
having avg(a.gpa) >= 2.5
order by 1;



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
