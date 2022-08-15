-- https://leetcode.com/problems/report-contiguous-dates/

with logs as (
    select *
    from (
        select 'failed' as evt, fail_date as dt from Failed union
        select 'succeeded' as evt, success_date as dt from Succeeded
    ) s
    where year(dt) = 2019
), chg as (
    select 
        evt, 
        dt, 
        case when lag(evt, 1) over(order by dt) = evt then 0 else 1 end as changed
    from logs
), cte as (
    select
        evt,
        dt,
        sum(changed) over(order by dt) as grp
    from chg
)

select * from (
    select 
        evt as period_state, 
        min(dt) as start_date,
        max(dt) as end_date
    from cte
    group by evt, grp
) s order by start_date;
