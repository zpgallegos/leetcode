-- https://leetcode.com/problems/game-play-analysis-iv/




select round(count(distinct a.player_id) / (select count(distinct player_id) from Activity), 2) as fraction
from Activity a inner join (
    select player_id, min(event_date) as first_login
    from Activity
    group by player_id
) s on a.event_date = date_add(s.first_login, interval 1 day) and a.player_id = s.player_id
