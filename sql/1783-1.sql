-- https://leetcode.com/problems/grand-slam-titles/

with wins as (
    select
        a.player_id,
        count(1) as grand_slams_count
    from (
        select Wimbledon as player_id from championships union all
        select Fr_open as player_id from championships union all
        select US_open as player_id from championships union all
        select Au_open as player_id from championships
    ) a
    group by 1
)

select
    a.player_id,
    b.player_name,
    a.grand_slams_count
from wins a
    inner join players b on a.player_id = b.player_id;
