-- https://leetcode.com/problems/low-quality-problems/description/

with cte as (
    select *, likes / cast(likes + dislikes as float) as like_perc
    from problems
)

select problem_id
from cte
where like_perc < .6
order by problem_id;
