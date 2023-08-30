-- https://leetcode.com/problems/count-student-number-in-departments/


select * from (
    select a.dept_name, count(student_id) as student_number
    from Department a left join Student b on a.dept_id = b.dept_id
    group by a.dept_id
) s
order by student_number desc, dept_name;
