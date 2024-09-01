-- https://leetcode.com/problems/game-play-analysis-iv/description/

with cte as (
    select
        a.player_id,
        date_add(min(a.event_date), interval 1 day) as next_login_date
    from activity a
    group by 1
)

select round(avg(if(b.event_date is not null, 1, 0)), 2) as fraction
from cte a
    left join activity b on a.player_id = b.player_id and a.next_login_date = b.event_date;