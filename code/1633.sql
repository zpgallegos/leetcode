

with cnt as (
    select count(1)
    from Users
)

select *
from (
    select
        contest_id,
        round((count(1) / (select * from cnt)) * 100, 2) as "percentage"
    from Register
    group by contest_id
) sub
order by sub.percentage desc, sub.contest_id