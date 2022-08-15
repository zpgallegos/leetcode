

select activity_date as day, count(distinct user_id) as active_users
from Activity
where activity_date between date_sub('2019-07-27', interval 29 day) and cast('2019-07-27' as date)
group by activity_date