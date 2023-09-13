-- https://leetcode.com/problems/delete-duplicate-emails/

with cte as (
    select *, rank() over(partition by email order by id asc) as rnk
    from person
)

delete from person where id in(select id from cte where rnk > 1);