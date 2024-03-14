-- https://leetcode.com/problems/all-valid-triplets-that-can-represent-a-country/

select
    a.student_name as member_A,
    b.student_name as member_B,
    c.student_name as member_C
from schoola a
    cross join schoolb b
    cross join schoolc c
where
    not(a.student_id = b.student_id or b.student_id = c.student_id or a.student_id = c.student_id) and
    not(a.student_name = b.student_name or b.student_name = c.student_name or a.student_name = c.student_name);