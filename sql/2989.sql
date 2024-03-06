-- https://leetcode.com/problems/class-performance/description/

with cte as (
    select
        student_id,
        assignment1 + assignment2 + assignment3 as total
    from scores
)

select max(total) - min(total) as difference_in_score
from cte;