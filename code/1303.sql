-- https://leetcode.com/problems/find-the-team-size/

select employee_id, team_size
from Employee a inner join (
    select team_id, count(distinct employee_id) as team_size
    from Employee
    group by team_id
) sub on a.team_id = sub.team_id;

select
    employee_id, 
    count(1) over(partition by team_id) as team_size
from Employee

select
    employee_id,
    count(1) over w as team_size

from Employee
window w as (partition by team_id)