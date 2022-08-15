-- https://leetcode.com/problems/grand-slam-titles/


with tournaments as (
    select wimbledon as winner from Championships union all
    select fr_open as winner from Championships union all
    select us_open as winner from Championships union all
    select au_open as winner from Championships
)

select b.player_id, b.player_name, count(1) as grand_slams_count
from tournaments a inner join Players b on a.winner = b.player_id
group by 1, 2;