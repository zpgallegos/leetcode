-- https://leetcode.com/problems/election-results/

with cte as (
    select
        a.candidate,
        1 / count(1) over win as votes
    from votes a
    window win as (partition by a.voter)
),
tabd as (
    select
        a.candidate,
        sum(votes) as total_votes
    from cte a
    group by 1
)

select candidate
from tabd
where total_votes = (select max(total_votes) from tabd)
order by 1;