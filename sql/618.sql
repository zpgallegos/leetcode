-- https://leetcode.com/problems/students-report-by-geography/

with cte as (
    select
        a.*,
        row_number() over(partition by a.continent order by a.name) as rn
    from student a
),
america as (select * from cte where continent = 'America'),
asia as (select * from cte where continent = 'Asia'),
europe as (select * from cte where continent = 'Europe')

select
    a.name as America,
    b.name as Asia,
    c.name as Europe
from america a
    left join asia b on a.rn = b.rn
    left join europe c on a.rn = c.rn
order by a.rn;