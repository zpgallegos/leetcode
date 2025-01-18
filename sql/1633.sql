-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/


select
    contest_id,
    round(count(*)::numeric / (select count(*) from users) * 100, 2) as percentage
from register
group by 1
order by 2 desc, 1;