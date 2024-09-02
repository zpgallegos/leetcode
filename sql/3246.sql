-- https://leetcode.com/problems/premier-league-table-ranking/description/


select
    s.*,
    rank() over win as position
from (
    select
        a.team_id,
        a.team_name,
        a.wins * 3 + a.draws as points
    from teamstats a
) s
window win as (order by s.points desc)
order by 3 desc, 2;
