-- https://leetcode.com/problems/find-cumulative-salary-of-an-employee/description/

with cte as (
    select sub.*
    from (
        select
            a.*,
            rank() over(partition by a.id order by a.month desc) as rnk
        from employee a
    ) sub
    where rnk > 1
),
lagged as (
    select
        a.*,
        coalesce(b.salary, 0) as lag_1,
        coalesce(c.salary, 0) as lag_2
    from cte a
        left join cte b on a.id = b.id and a.month - 1 = b.month
        left join cte c on a.id = c.id and a.month - 2 = c.month
)

select
    a.id,
    a.month,
    a.salary + a.lag_1 + a.lag_2 as Salary
from lagged a
order by a.id, a.month desc;