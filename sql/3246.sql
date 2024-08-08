-- https://leetcode.com/problems/finding-the-topic-of-each-post/description/


with cte as (
    select
        a.team_id,
        a.team_name,
        sum(a.wins * 3) + sum(a.draws) as points
    from teamstats a
    group by 1, 2
),
ranked as (
    select
        a.*,
        rank() over(order by a.points desc) as position
    from cte a
)

select a.*
from ranked a
order by a.position, a.team_name;