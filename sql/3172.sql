-- https://leetcode.com/problems/second-day-verification/description/

select a.user_id
from emails a
    inner join texts b on a.email_id = b.email_id
where
    1=1
    and b.signup_action = 'Verified'
    and date_add(date(a.signup_date), interval 1 day) = date(b.action_date)
order by 1;