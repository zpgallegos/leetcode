create function getNthHighestSalary(N int) returns int begin return (
    select sub.salary
    from (
        select s.salary, row_number() over(order by s.salary desc) as rw
        from (
            select distinct salary
            from Employee
        ) s
    ) sub
    where sub.rw = N
);

end