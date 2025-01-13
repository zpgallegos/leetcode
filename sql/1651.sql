-- https://leetcode.com/problems/hopper-company-queries-iii/


with recursive

all_months as (
    select 1 as month union
    select a.month + 1 from all_months a where a.month < 12
),

agg as (
    select
        extract(month from a.requested_at) as month,
        sum(b.ride_distance) as total_ride_distance,
        sum(b.ride_duration) as total_ride_duration
    from rides a
        inner join acceptedrides b on a.ride_id = b.ride_id
    where
        1=1
        and requested_at >= '2020-01-01'
        and requested_at <= '2020-12-31'
    group by 1
),

agg_filled as (
    select
        a.month,
        coalesce(b.total_ride_distance, 0) as total_ride_distance,
        coalesce(b.total_ride_duration, 0) as total_ride_duration
    from all_months a
        left join agg b on a.month = b.month
),

res as (
    select
        a.month,
        round(avg(total_ride_distance) over win, 2) as average_ride_distance,
        round(avg(total_ride_duration) over win, 2) as average_ride_duration
    from agg_filled a
    window win as (
        order by a.month
        rows between current row and 2 following
    )
)

select * from res where month <= 10;