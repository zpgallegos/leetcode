-- https://leetcode.com/problems/game-play-analysis-iii

select
    a.player_id,
    a.event_date,
    sum(a.games_played) over win as games_played_so_far
from activity a
window win as (
    partition by a.player_id 
    order by a.event_date
    rows between unbounded preceding and current row
)