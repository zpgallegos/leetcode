-- https://leetcode.com/problems/find-followers-count/description/


select user_id, count(1) as followers_count
from followers
group by 1
order by 1;