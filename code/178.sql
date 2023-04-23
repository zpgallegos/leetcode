-- https://leetcode.com/problems/rank-scores/

with cte as (
    select
        score,
        dense_rank() over(order by score desc) as "rank"
    from scores
)

select *
from cte
order by cte.rank;