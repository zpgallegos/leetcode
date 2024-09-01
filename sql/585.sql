-- https://leetcode.com/problems/investments-in-2016/description/


with qa as (
    select tiv_2015 from insurance group by 1 having count(1) > 1
),
qb as (
    select lat, lon from insurance group by 1, 2 having count(1) = 1
)

select round(sum(a.tiv_2016), 2) as tiv_2016
from insurance a
where
    1=1
    and a.tiv_2015 in(select * from qa)
    and (a.lat, a.lon) in(select * from qb);