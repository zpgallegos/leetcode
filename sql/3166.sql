-- https://leetcode.com/problems/calculate-parking-fees-and-duration/description/


with cte as (
    select
        s.*,
        row_number() over(partition by s.car_id order by s.lot_hours desc) as rn
    from (
        select
            a.car_id,
            a.lot_id,
            sum(a.fee_paid) as lot_fee_paid,
            sum(timestampdiff(second, a.entry_time, a.exit_time)) / (60 * 60) as lot_hours
        from parkingtransactions a
        group by 1, 2
    ) s
),
aggd as (
    select
        a.car_id,
        sum(a.lot_fee_paid) as total_fee_paid,
        round(sum(a.lot_fee_paid) / sum(a.lot_hours), 2) as avg_hourly_fee
    from cte a
    group by 1
),
top_lots as (
    select 
        a.car_id, 
        a.lot_id as most_time_lot
    from cte a
    where rn = 1
)

select
    a.*,
    b.most_time_lot
from aggd a
    inner join top_lots b on a.car_id = b.car_id
order by 1;