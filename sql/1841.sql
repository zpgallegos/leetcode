-- https://leetcode.com/problems/league-statistics/description/

with mtch as (
    select
        a.home_team_id as team_id,
        a.home_team_goals as goals_for,
        a.away_team_goals as goals_against
    from matches a

    union all

    select
        a.away_team_id as team_id,
        a.away_team_goals as goals_for,
        a.home_team_goals as goals_against
    from matches a
),
agg as (
    select
        b.team_name,
        count(1) as matches_played,
        sum(goals_for) as goal_for,
        sum(goals_against) as goal_against,
        sum(case when a.goals_for > a.goals_against then 3 when a.goals_for = a.goals_gainst then 1 else 0 end) as points
    from mtch a
        inner join teams b on a.team_id = b.team_id
    group by 1
)

select
    team_name,
    matches_played,
    points,
    goal_for,
    goal_against,
    goal_for - goal_against as goal_diff
from agg
order by 3 desc, 6 desc, 1;