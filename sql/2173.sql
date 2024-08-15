-- https://leetcode.com/problems/longest-winning-streak/description/

with cte as (
    select
        a.*,
        lag(a.result, 1) over win as last_result
    from matches a
    window win as (partition by a.player_id order by a.match_day)
),
incrd as (
    select
        a.*,
        if(a.last_result = 'Win' and a.result = 'Win', 0, 1) as incr
    from cte a
),
grpd as (
    select
        a.*,
        sum(a.incr) over win as grp
    from incrd a
    window win as (partition by a.player_id order by a.match_day rows between unbounded preceding and current row)
),
streaks as (
    select
        a.player_id,
        a.grp,
        count(1) as streak
    from grpd a
    where a.result = 'Win'
    group by 1, 2
),
max_streak as (
    select
        a.player_id,
        max(a.streak) as longest_streak
    from streaks a
    group by 1
)

select * from max_streak 

union

select distinct a.player_id, 0 as longest_streak 
from matches a
where a.player_id not in(select player_id from max_streak);
