-- https://leetcode.com/problems/nth-highest-salary/


create function getNthHighestSalary(N int) returns int
begin return (
    with cte as (
        select
            a.salary,
            dense_rank() over(order by a.salary desc) as rnk
        from employee a
    )

    select max(salary) from cte where rnk = N
);
end