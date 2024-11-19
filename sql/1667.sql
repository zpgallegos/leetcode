-- https://leetcode.com/problems/fix-names-in-a-table/


select
    user_id,
    upper(substring(name, 1, 1)) || lower(substring(name, 2, length(name))) as name
from users
order by 1;