-- https://leetcode.com/problems/low-quality-problems/description/

select problem_id
from problems
where likes::float / (likes + dislikes) < .6
order by 1;