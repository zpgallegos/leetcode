-- https://leetcode.com/problems/total-traveled-distance/

select a.user_id, a.name, coalesce(sum(b.distance), 0) as 'traveled distance'
from users a left join rides b on a.user_id = b.user_id
group by a.user_id, a.name
order by a.user_id;