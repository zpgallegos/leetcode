-- https://leetcode.com/problems/restaurant-growth/

with day_totals as (
    select
        a.visited_on,
        sum(a.amount) as amount
    from customer a
    group by 1
), cte as (
    select
        a.visited_on,
        sum(a.amount) over win as amount,
        round(avg(a.amount) over win, 2) as average_amount,
        count(a.amount) over win as day_count
    from day_totals a
    window win as (order by a.visited_on rows between 6 preceding and current row)
)

select visited_on, amount, average_amount
from cte
where day_count = 7;

-- without window functions...

with day_totals as (
    select
        a.visited_on,
        sum(a.amount) as amount
    from customer a
    group by 1
)

select
    a.visited_on,
    sum(b.amount) as amount,
    round(avg(b.amount), 2) as average_amount
from day_totals a
    inner join day_totals b on b.visited_on between date_sub(a.visited_on, interval 6 day) and a.visited_on
group by 1
having count(b.visited_on) = 7
order by 1;