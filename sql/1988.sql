-- https://leetcode.com/problems/find-cutoff-score-for-each-school/description/


select
    a.school_id,
    coalesce(min(b.score), -1) as score
from schools a
    left join exam b on b.student_count <= a.capacity
group by 1;