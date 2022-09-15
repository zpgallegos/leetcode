-- https://leetcode.com/problems/game-play-analysis-ii/

select
    a.player_id,
    a.device_id
    
from activity a
    inner join (
        select player_id, min(event_date) as first_login
        from activity
        group by player_id
    ) s on a.player_id = s.player_id and a.event_date = s.first_login