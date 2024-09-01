-- https://leetcode.com/problems/rank-scores/description/

select
    a.score,
    dense_rank() over(order by a.score desc) as `rank`
from scores a
order by 2;