-- https://leetcode.com/problems/duplicate-emails/description/

select email
from person
group by 1
having count(1) > 1;