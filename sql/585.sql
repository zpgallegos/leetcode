-- https://leetcode.com/problems/investments-in-2016/submissions/?lang=pythondata?envType=daily-question&envId=2023-09-01


select sum(tiv_2016) as tiv_2016
from insurance
where
    tiv_2015 in(
        select tiv_2015
        from insurance
        group by tiv_2015
        having count(1) > 1
    ) and
    (lat, lon) not in(
        select lat, lon
        from insurance
        group by lat, lon
        having count(1) > 1
    )