-- https://leetcode.com/problems/find-customer-referee/description/

select a.name
from customer a
where
    a.referee_id is null or
    a.referee_id != 2;