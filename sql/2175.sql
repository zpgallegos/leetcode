-- https://leetcode.com/problems/the-change-in-global-rankings/description/

with cte as (
    select
        a.*,
        a.points + coalesce(b.points_change, 0) as new_points
    from teampoints a
        left join pointschange b on a.team_id = b.team_id
)

select
    a.team_id,
    a.name,
    rank() over win1 - rank() over win2 as rank_diff
from cte a
window win1 as (order by a.points desc, a.name), win2 as (order by a.new_points desc, a.name);