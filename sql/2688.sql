-- https://leetcode.com/problems/find-active-users/

with cte as (
    select
        user_id,
        created_at - lag(created_at) over(partition by user_id order by created_at asc) as diff
    from users
)

select distinct user_id from cte where diff <= 7;