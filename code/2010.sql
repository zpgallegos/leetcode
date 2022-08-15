-- https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company-ii/

with ranked as (
    select
        employee_id,
        experience,
        sum(salary) over (partition by experience order by salary) as spent
    from Candidates
), seniors as (
    select employee_id, spent
    from ranked
    where experience = 'Senior' and spent <= 70000
)

select employee_id
from ranked
where experience = 'Junior' and spent <= 70000 - coalesce((select max(spent) from seniors), 0)

union

select employee_id from seniors;