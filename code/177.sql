-- https://leetcode.com/problems/nth-highest-salary/

create function getNthHighestSalary(N int) returns int
begin
    return (
        select distinct salary 
        from (
            select
                *,
                dense_rank() over(order by salary desc) as rnk
            from employee
        ) s
        where rnk = N
    );
end