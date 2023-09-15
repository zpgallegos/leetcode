-- https://leetcode.com/problems/user-activity-for-the-past-30-days-ii/

with cte as (
    select user_id, count(distinct session_id) as cnt
    from activity
    where 
        activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27'
        -- "The sessions we want to count for a user are those with at least one activity in that time period"
        -- ??? apparently not
        -- activity_type not in('open_session', 'end_session')
    group by user_id
)

select coalesce(round(avg(cnt), 2), 0) average_sessions_per_user from cte;