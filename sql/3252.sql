-- https://leetcode.com/problems/premier-league-table-ranking-ii/description/

with cte as (
    select
        a.team_name,
        sum(a.wins * 3 + a.draws) as points
    from teamstats a
    group by 1
),
ranked as (
    select
        a.*,
        rank() over(order by a.points desc) as position,
        count(1) over() as n_teams
    from cte a
)


select
    a.team_name,
    a.points,
    a.position,
    case
    when a.position < (.33 * a.n_teams) + 1 then 'Tier 1'
    when a.position < (.66 * a.n_teams) + 1 then 'Tier 2'
    else 'Tier 3'
    end as tier
from ranked a
order by a.points desc, a.team_name
