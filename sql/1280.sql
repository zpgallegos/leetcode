-- https://leetcode.com/problems/students-and-examinations/


select * from (
    select
        a.student_id,
        a.student_name,
        a.subject_name,
        count(b.subject_name) as attended_exams

    from (
        select *
        from Students, Subjects
    ) a left join Examinations b on a.student_id = b.student_id and a.subject_name = b.subject_name

    group by 1, 2, 3
) s order by student_id, subject_name;