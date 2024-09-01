-- https://leetcode.com/problems/find-users-with-valid-e-mails/description/


select *
from users
where mail regexp "^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$";