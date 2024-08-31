-- https://leetcode.com/problems/delete-duplicate-emails/description/

with cte as (
    select
        a.*,
        row_number() over(partition by a.email order by a.id) as rn
    from person a
)

delete from person where id in(select id from cte where rn > 1);