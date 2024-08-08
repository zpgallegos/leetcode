-- https://leetcode.com/problems/active-users/

-- one way, using the cumulative sum grouping gimmick

with uniq as (
    select distinct a.id, a.login_date
    from logins a
),
stg as (
    select
        a.*,
        lag(a.login_date, 1) over win as last_login
    from uniq a
    window win as (partition by a.id order by a.login_date)
),
cte as (
    select
        a.*,
        if(a.last_login is null or datediff(a.login_date, a.last_login) > 1, 1, 0) as incr
    from stg a
),
grpd as (
    select
        a.id,
        sum(a.incr) over win as grp
    from cte a
    window win as (partition by a.id order by a.login_date)
)

select a.id, b.name
from (
    select distinct a.id
    from grpd a
    group by a.id, a.grp
    having count(1) >= 5
) a inner join accounts b on a.id = b.id
order by 1;

-- another way, using lead

with uniq as (
    select distinct a.id, a.login_date
    from logins a
),
cte as (
    select
        a.id,
        if(date_add(a.login_date, interval 4 day) = lead(a.login_date, 4) over win, true, false) as qual
    from uniq a
    window win as (partition by a.id order by a.login_date)
)

select a.id, b.name
from (
    select distinct a.id
    from cte a
    where a.qual
) a inner join accounts b on a.id = b.id
order by 1;