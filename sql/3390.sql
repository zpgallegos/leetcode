-- https://leetcode.com/problems/longest-team-pass-streak/description/


with cte as (
    select
        b.team_name,
        substring(time_stamp, 1, 2)::numeric +
            substring(time_stamp, 4, 2)::numeric / 60 as time_num,
        case
            when b.team_name = c.team_name then 1
            else 0
        end as success
    from passes a
        inner join teams b on a.pass_from = b.player_id
        inner join teams c on a.pass_to = c.player_id
),
incr as (
    select
        a.*,
        case
            when a.success = 1 and lag(a.success, 1) over win = 1 then 0
            else 1
        end as incr
    from cte a
    window win as (partition by a.team_name order by a.time_num)
),
grpd as (
    select
        a.*,
        sum(a.incr) over win as grp
    from incr a
    window win as (
        partition by a.team_name
        order by a.time_num 
        rows between unbounded preceding and current row
    )
),
aggd as (
    select
        a.team_name,
        a.grp,
        count(1) as cnt
    from grpd a
    where a.success = 1
    group by 1, 2
)

select
    team_name,
    max(cnt) as longest_streak
from aggd
group by 1
order by 1;
