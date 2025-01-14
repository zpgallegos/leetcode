-- https://leetcode.com/problems/hopper-company-queries-ii/description/


with recursive

all_months as (

    select 1 as month union
    select a.month + 1 from all_months a where a.month < 12

),

n_drivers as (

    select
        sub.month,
        max(sub.driver_count) as driver_count
    from (
        select
            a.join_date,
            extract(month from a.join_date) as month,
            count(1) over win as driver_count
        from drivers a
        where a.join_date <= '2020-12-31'
        window win as (
            order by a.join_date
            rows between unbounded preceding and current row
        )
    ) sub
    where sub.join_date >= '2020-01-01'
    group by 1

),

n_drivers_filled as (

    select
        a.month,
        coalesce(max(b.driver_count) over win, 0) as driver_count
    from all_months a
        left join n_drivers b on a.month = b.month
    window win as (
        order by a.month
        rows between unbounded preceding and current row
    )

),

n_drove as (

    select
        extract(month from a.requested_at) as month,
        count(distinct b.driver_id)::numeric as drove_count
    from rides a
        inner join acceptedrides b on a.ride_id = b.ride_id
    where a.requested_at between '2020-01-01' and '2020-12-31'
    group by 1

)

select
    a.month,
    case
        when a.driver_count = 0 then 0
        else round((coalesce(b.drove_count, 0) / a.driver_count) * 100, 2) 
    end as working_percentage
from n_drivers_filled a
    left join n_drove b on a.month = b.month
order by 1;



-- https://leetcode.com/problems/hopper-company-queries-ii/

with recursive date_range as(
    select '2020-01-01' as dt
    union all
    select dt + interval 1 day from date_range where dt < '2020-12-31'
),
all_months as (
    select
        month(dt) as month,
        max(dt) as month_last_day
    from date_range
    group by 1
),
driver_cnts_stg as (
    select
        b.month,
        count(1) as n_drivers
    from drivers a 
        inner join all_months b on a.join_date <= b.month_last_day
    group by 1
),
driver_cnts as (
    select * from driver_cnts_stg union
    select a.month, 0 as n_drivers from all_months a where a.month not in(select month from driver_cnts_stg)
),
working_cnts_stg as (
    select
        month(a.requested_at) as month,
        count(distinct b.driver_id) as n_working
    from rides a
        inner join acceptedrides b on a.ride_id = b.ride_id
    where a.requested_at between '2020-01-01' and '2020-12-31'
    group by 1
),
working_cnts as (
    select * from working_cnts_stg union
    select a.month, 0 as n_working from all_months a where a.month not in(select month from working_cnts_stg)
)

select
    a.month,
    coalesce(round((b.n_working / a.n_drivers) * 100, 2), 0) as working_percentage
from driver_cnts a
    inner join working_cnts b on a.month = b.month
order by 1;