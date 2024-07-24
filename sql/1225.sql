-- https://leetcode.com/problems/report-contiguous-dates/

with logs as (
    select a.fail_date as dt, 'failed' as period_state from failed a union
    select a.success_date as dt, 'succeeded' as period_state from succeeded a
),
cte as (
    select
        a.*,
        if(period_state != lag(period_state) over(order by dt), 1, 0) as chg
    from logs a
    where dt between '2019-01-01' and '2019-12-31'
),
grpd as (
    select a.*, sum(chg) over(order by dt) as grp
    from cte a
)

select
    a.period_state,
    min(a.dt) as start_date,
    max(a.dt) as end_date
from grpd a
group by a.period_state, a.grp
order by start_date;