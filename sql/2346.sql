-- https://leetcode.com/problems/compute-the-rank-as-a-percentage/description/

with cte as (
    select
        a.*,
        rank() over (partition by a.department_id order by a.mark desc) as rnk,
        count(1) over(partition by a.department_id) as dep_n
    from students a
),
cst as (
    select
        a.*,
        (rnk - 1) * 100.0 as num,
        case when dep_n - 1 = 0 then 1.0 else (dep_n - 1.0) end as den
    from cte a
)

select
    student_id,
    department_id,
    round(num / den, 2) as percentage
from cst;
