
with games as (
    select
        *,
        case
        when home_team_goals > away_team_goals then 3
        when home_team_goals < away_team_goals then 0
        else 1
        end as home_points,
        case
        when home_team_goals > away_team_goals then 0
        when home_team_goals < away_team_goals then 3
        else 1
        end as away_points
    
    from Matches
), stats as (

    select
        a.*,
        b.home_team_goals as goals_for,
        b.away_team_goals as goals_against,
        b.home_team_goals - b.away_team_goals as goals_diff,
        b.home_points as points
    from Teams a inner join games b on a.team_id = b.home_team_id

    union all -- don't drop games that happen to have the same scores

    select
        a.*,
        b.away_team_goals as goals_for,
        b.home_team_goals as goals_against,
        b.away_team_goals - b.home_team_goals as goals_diff,
        b.away_points as points
    from Teams a inner join games b on a.team_id = b.away_team_id

)

select sub.* from (
    select
        team_name,
        count(1) as matches_played,
        sum(points) as points,
        sum(goals_for) as goal_for,
        sum(goals_against) as goal_against,
        sum(goals_diff) as goal_diff

    from stats

    group by team_name
) sub order by sub.points desc, goal_diff desc, team_name;