-- https://leetcode.com/problems/activity-participants/

with cnts as (
    select
        a.activity,
        count(1) as cnt
    from friends a
    group by 1
),
filled as (
    select * from cnts 
    
    union
    
    select a.name, 0 as cnt
    from activities a
    where a.name not in(select activity from cnts)
)

select a.activity
from filled a
where 
    1=1
    and a.cnt < (select max(cnt) from filled)
    and a.cnt > (select min(cnt) from filled);
