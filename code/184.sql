-- https://leetcode.com/problems/department-highest-salary/

select
    sub.Department,
    a.name as Employee,
    a.salary as Salary


from (
    select b.id, b.name as Department, max(a.salary) as dep_max
    from Employee a inner join Department b on a.departmentId = b.id
    group by b.id
) sub inner join Employee a on sub.id = a.departmentId and sub.dep_max = a.salary
