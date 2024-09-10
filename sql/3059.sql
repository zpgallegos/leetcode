-- https://leetcode.com/problems/find-all-unique-email-domains/description/

select
    substring(a.email from '(?<=@)[\w-]+.com') as email_domain,
    count(1) as count
from emails a
where a.email ilike '%.com'
group by 1
order by 1;


-- https://leetcode.com/problems/find-all-unique-email-domains/description/

with cte as (
    select *,
        right(lower(email), 4) as ending,
        charindex('@', email) as sep
    from emails
), dom as (
    select *, substring(email, sep + 1, len(email)) as email_domain
    from cte
    where ending = '.com'
)

select * from (
    select email_domain, count(1) as count
    from dom
    group by email_domain
) sub order by email_domain;
