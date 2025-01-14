-- https://leetcode.com/problems/hopper-company-queries-i/description/


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
        coalesce(max(b.driver_count) over win, 0) as active_drivers
    from all_months a
        left join n_drivers b on a.month = b.month
    window win as (
        order by a.month
        rows between unbounded preceding and current row
    )

),

acc as (
    
    select
        a.month,
        coalesce(sub.accepted_rides, 0) as accepted_rides
    from all_months a
        left join (
            select
                extract(month from a.requested_at) as month,
                count(1) as accepted_rides
            from rides a
                inner join acceptedrides b on a.ride_id = b.ride_id
            where a.requested_at between '2020-01-01' and '2020-12-31'
            group by 1
        ) sub on a.month = sub.month

)

select
    a.*,
    b.accepted_rides
from n_drivers_filled a
    inner join acc b on a.month = b.month;

    

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
