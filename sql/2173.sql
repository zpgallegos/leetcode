-- https://leetcode.com/problems/longest-winning-streak/

with grpd as (
    select
        a.*,
        sum(case when result != 'Win' then 1 else 0 end) over win as grp
    from matches a
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
