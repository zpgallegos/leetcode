insert into leetcode.Employee values
      (4, 'Max', 90000, 1),
      (1, 'Joe', 85000, 1),
      (6, 'Randy', 85000, 1),
      (7, 'Will', 70000, 1),
      (5, 'Janet', 69000, 1),
      (2, 'Henry', 80000, 2),
      (3, 'Sam', 60000, );

select
    b.name as Department,
    a.name as Employee,
    a.salary as Salary

from Employee a
    inner join Department b on a.departmentId = b.id
    inner join (
        select distinct
            dst.departmentId,
            dst.salary

        from (
            select
                departmentId, 
                salary,
                rank() over(partition by departmentId order by salary desc) as rnk
            from (
                select distinct departmentId, salary
                from Employee
            ) uniq
        ) dst
        where dst.rnk <= 3
    ) sub on a.departmentId = sub.departmentId and a.salary = sub.salary;


with ranks as (
    select distinct
        departmentId, 
        salary, 
        dense_rank() over(partition by departmentId order by salary desc) as rnk
    
    from Employee
)

select
    b.name as Department,
    a.name as Employee,
    c.salary as Salary
    
from Employee a
    inner join Department b on a.departmentId = b.id
    inner join ranks c on a.departmentId = c.departmentId and a.salary = c.salary

where
    c.rnk <= 3