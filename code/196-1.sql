-- https://leetcode.com/problems/delete-duplicate-emails/description/

with cte as (
    select b.id
    from person a inner join person b on a.email = b.email
    where b.id > a.id
)

delete from person where id in (select id from cte);