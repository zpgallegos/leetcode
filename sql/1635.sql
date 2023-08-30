-- https://leetcode.com/problems/hopper-company-queries-i/

with recursive all_months as (
    select 1 as month
    union
    select month + 1 from all_months where month < 12
),
d as (
    select
        all_months.month,
        coalesce(max(q.active_drivers), 0) as active_drivers

    from all_months
        left join (
            select
                month,
                max(active_drivers) as active_drivers
            
            from (
                select
                    *,
                    month(join_date) as month,
                    row_number() over(order by join_date) as active_drivers
                from drivers
            ) s
            where year(join_date) = 2020
            group by month
        ) q on q.month <= all_months.month
    
    group by all_months.month
),
r as (
    select
        month(a.requested_at) as month,
        count(1) as accepted_rides
    from rides a
        inner join acceptedrides b on a.ride_id = b.ride_id
    where year(a.requested_at) = 2020
    group by month(a.requested_at)
),
all_r as (
    select * from r
    
    union
    
    select all_months.month, 0 as accepted_rides 
    from all_months
        left join r on all_months.month = r.month
    where r.month is null
)

select d.month, d.active_drivers, all_r.accepted_rides
from d inner join all_r on d.month = all_r.month
order by d.month;
