-- https://leetcode.com/problems/game-play-analysis-iii/

select
    player_id,
    event_date,
    sum(games_played) over win as games_played_so_far

from Activity

window win as (
    partition by player_id 
    order by event_date
    rows between unbounded preceding and current row)
