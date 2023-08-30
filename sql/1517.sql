-- https://leetcode.com/problems/find-users-with-valid-e-mails/

select
    a.user_id,
    a.name,
    a.mail

from users a

where a.mail regexp "^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com";