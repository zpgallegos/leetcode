-- https://leetcode.com/problems/nth-highest-salary/

create function getNthHighestSalary(@N int) returns int as
begin
return (
    select max(salary)
    from (
        select *, dense_rank() over(order by salary desc) as rnk
        from employee
        ) sub
    where rnk = @N
);
end;