-- https://leetcode.com/problems/premier-league-table-ranking-iii/

with cte as (
    select
        a.*,
        a.wins * 3 + a.draws as points,
        a.goals_for - a.goals_against as dif
    from seasonstats a
),
tbl as (
    select
        a.season_id,
        a.team_id,
        a.team_name,
        sum(a.points) as points,
        sum(a.dif) as goal_difference
    from cte a
    group by 1, 2, 3
)

select * from (
    select
        a.*,
        rank() over win as position
    from tbl a
    window win as (
        partition by a.season_id 
        order by a.points desc, a.goal_difference desc, a.team_name
    )
) s
order by s.season_id, s.position, s.team_name;
