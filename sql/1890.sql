-- https://leetcode.com/problems/the-latest-login-in-2020/


select user_id, max(time_stamp) as last_stamp
from logins
where extract(year from time_stamp) = 2020
group by 1;