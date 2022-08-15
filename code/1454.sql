-- https://leetcode.com/problems/active-users/

with log as (
    select
        id,
        login_date,
        if(date_add(login_date, interval 4 day) = lead(login_date, 4) over win, 1, 0) as start_streak
    from (
        select distinct id, login_date
        from Logins
    ) s
    window win as (partition by id order by login_date)
)

select distinct a.id, b.name
from log a inner join Accounts b on a.id = b.id
where start_streak
order by a.id;