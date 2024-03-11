-- https://leetcode.com/problems/create-a-session-bar-chart/description/

with tmp as (
    select *, duration / 60. as mins
    from sessions
), cte as (
   select *,
        case
        when mins < 5 then '[0-5>'
        when mins < 10 then '[5-10>'
        when mins < 15 then '[10-15>'
        else '15 or more'
        end as bin
    from tmp
), bins as (
    select '[0-5>' as bin union
    select '[5-10>' as bin union
    select '[10-15>' as bin union
    select '15 or more' as bin
), res as (
    select bin, count(1) as total
    from cte
    group by bin
)

select * from res union
select bin, 0 as total from bins where bin not in(select bin from res);