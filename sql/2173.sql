-- https://leetcode.com/problems/longest-winning-streak/

with incr as (
    select
        a.*,
        case
        when (lag(a.result, 1) over win) = 'Win' and a.result != 'Win' then 1
        else 0
        end as incr
    from matches a
    window win as(partition by a.player_id  order by a.match_day)
),
grpd as (
    select
        a.*,
        sum(incr) over win as grp
    from incr a
    window win as (
        partition by a.player_id
        order by a.match_day
        rows between unbounded preceding and current row
    )
),
mx as (
    select
        a.player_id,
        a.grp,
        count(1) as streak
    from grpd a
    where a.result = 'Win'
    group by 1, 2
),
longs as (
    select player_id, max(streak) as longest_streak
    from mx
    group by 1
)

select * from longs union
select distinct player_id, 0 from matches where player_id not in(select player_id from longs);
