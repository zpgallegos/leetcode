-- https://leetcode.com/problems/election-results/

with cte as (
    select
        voter,
        candidate,
        1 / count(1) over(partition by voter) as vote_weight
    from votes
    where candidate is not null
),
cand as (
    select candidate, sum(vote_weight) as vote_weight
    from cte
    group by candidate
)

select candidate
from cand
where vote_weight = (select max(vote_weight) from cand)
order by candidate;