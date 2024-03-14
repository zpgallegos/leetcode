-- https://leetcode.com/problems/game-play-analysis-iv/description/

with cte as (
    select player_id, dateadd(day, 1, min(event_date)) as join_date
    from activity
    group by player_id
), num as(
    select cast(count(distinct a.player_id) as float) as cnt
    from cte a inner join activity b on a.player_id = b.player_id and a.join_date = b.event_date
), denom as (
    select cast(count(distinct player_id) as float) as cnt
    from activity
)

select round((select * from num) / (select * from denom), 2) as fraction;


-- worse

with cte as (
    select *,
        dense_rank() over(partition by player_id order by event_date) as rnk,
        datediff(day, lag(event_date, 1) over(partition by player_id order by event_date), event_date) as diff
    from activity
)

select 
    round(
        (select count(distinct player_id) from cte where rnk = 2 and diff = 1) / 
        cast((select count(distinct player_id) from activity) as float)
    , 2) as fraction
