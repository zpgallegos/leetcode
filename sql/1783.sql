-- https://leetcode.com/problems/grand-slam-titles/description/

with cte as (
    select player_id, count(1) as grand_slams_count
    from (
        select wimbledon as player_id from championships union all
        select fr_open as player_id from championships union all
        select us_open as player_id from championships union all
        select au_open as player_id from championships
    ) s
    group by 1
)

select
    a.player_id,
    b.player_name,
    a.grand_slams_count
from cte a
    inner join players b on a.player_id = b.player_id