-- https://leetcode.com/problems/calculate-parking-fees-and-duration/description/


with cte as (
    select *,
        time_to_sec(timediff(exit_time, entry_time)) / 3600 as hrs
    from parkingtransactions
), lot_agg as (
    select
        sub.*,
        row_number() over(partition by sub.car_id order by sub.total_hrs desc) as rn
    from (
        select
            car_id,
            lot_id,
            sum(hrs) as total_hrs
        from cte
        group by
            car_id,
            lot_id
    ) sub
), car_agg as (
    select
        car_id,
        sum(fee_paid) as total_fee_paid,
        round(sum(fee_paid) / sum(hrs), 2) as avg_hourly_fee
    from cte
    group by car_id
)

select a.*, b.lot_id as most_time_lot
from car_agg a
    inner join lot_agg b on a.car_id = b.car_id
where b.rn = 1
order by a.car_id;