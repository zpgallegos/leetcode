-- https://leetcode.com/problems/second-day-verification/description/

select
    a.user_id
from emails a
    inner join texts b on a.email_id = b.email_id
where
    b.signup_action = 'Verified' and
    date(b.action_date) = date(date_add(a.signup_date, interval 1 day))
order by a.user_id;