-- https://leetcode.com/problems/game-play-analysis-iii/description/?lang=pythondata?envType=daily-question&envId=2023-09-01

select
    player_id,
    event_date,
    sum(games_played) over(partition by player_id order by event_date) as games_played_so_far

from activity;