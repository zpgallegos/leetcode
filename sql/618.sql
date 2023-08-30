-- https://leetcode.com/problems/students-report-by-geography/

with america as (
    select name as America, row_number() over(order by name) as rw
    from Student
    where continent = 'America'
), asia as (
    select name as Asia, row_number() over(order by name) as rw
    from Student
    where continent = 'Asia'
), europe as (
    select name as Europe, row_number() over(order by name) as rw
    from Student
    where continent = 'Europe'
)

select a.America, b.Asia, c.Europe
from america a
    left join asia b on a.rw = b.rw
    left join europe c on a.rw = c.rw
order by a.rw;