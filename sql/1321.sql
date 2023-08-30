-- https://leetcode.com/problems/restaurant-growth/

with daily as (
    select visited_on, sum(amount) as sm
    from Customer
    group by visited_on
)

select * from (
    select
        a.visited_on,
        sum(b.sm) as amount,
        round(avg(b.sm), 2) as average_amount

    from daily a cross join daily b
    where b.visited_on between date_sub(a.visited_on, interval 6 day) and a.visited_on
    group by a.visited_on
    having count(b.visited_on) = 7
) s order by visited_on;

-- with window functions

with daily as (
    select visited_on, sum(amount) as amount
    from Customer
    group by visited_on
)

select
    s.visited_on,
    s.running as amount,
    round(s.running / 7, 2) as average_amount

from (
    select
        visited_on,
        rank() over(order by visited_on) as days_in,
        sum(amount) over(order by visited_on rows between 6 preceding and current row) as running
    from daily
) s
where s.days_in >= 7
order by s.visited_on
