-- https://leetcode.com/problems/team-dominance-by-pass-success/description/


with cte as (
    select
        b.team_name,
        c.team_name as pass_to_team,
        substring(a.time_stamp, 1, 2)::numeric + 
            substring(a.time_stamp, 4, 2)::numeric / 60.0 as time_num
    from passes a
        inner join teams b on a.pass_from = b.player_id
        inner join teams c on a.pass_to = c.player_id
),
tbl as (
    select
        team_name,
        case
            when time_num <= 45 then 1
            else 2
        end as half_number,
        case
            when team_name = pass_to_team then 1
            else -1
        end as points
    from cte
)

select
    team_name,
    half_number,
    sum(points) as dominance
from tbl
group by 1, 2
order by 1, 2;
