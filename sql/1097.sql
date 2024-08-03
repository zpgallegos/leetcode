-- https://leetcode.com/problems/game-play-analysis-v/description/

with cte as (
    select
        a.player_id,
        min(a.event_date) as install_dt,
        date_add(min(a.event_date), interval 1 day) as next_dt
    from activity a
    group by a.player_id
),
cnts as (
    select
        a.install_dt,
        count(distinct a.player_id) as installs,
        count(distinct b.player_id) as retained
    from cte a
        left join activity b on a.player_id = b.player_id and a.next_dt = b.event_date
    group by a.install_dt
)

select 
    a.install_dt, 
    a.installs, 
    round(a.retained / a.installs, 2) as Day1_retention
from cnts a;