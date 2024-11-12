-- https://leetcode.com/problems/find-interview-candidates/description/

with cte as (
    select contest_id, gold_medal as user_id from contests union
    select contest_id, silver_medal as user_id from contests union
    select contest_id, bronze_medal as user_id from contests
),
incr as (
    select
        a.*,
        case
        when a.contest_id - lag(a.contest_id, 1) over win > 1 then 1
        else 0
        end as incr
    from cte a
    window win as (partition by a.user_id order by a.contest_id)
),
cum as (
    select
        a.*,
        sum(a.incr) over win as grp
    from incr a
    window win as (
        partition by a.user_id 
        order by a.contest_id
        rows between unbounded preceding and current row
    )
),
quals as (
    select user_id
    from cum
    group by user_id, grp
    having count(1) >= 3

    union

    select gold_medal as user_id
    from contests
    group by 1
    having count(1) >= 3
)

select b.name, b.mail
from quals a
    inner join users b on a.user_id = b.user_id;
