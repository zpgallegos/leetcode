-- https://leetcode.com/problems/class-performance/description/

with cte as (
    select a.assignment1 + a.assignment2 + a.assignment3 as score
    from scores a
)

select max(score) - min(score) as difference_in_score
from cte;