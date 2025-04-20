--  https://leetcode.com/problems/find-valid-emails/description/

select *
from users
where email ~ '^\w+@[a-zA-Z]+.com';