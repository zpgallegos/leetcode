-- https://leetcode.com/problems/median-employee-salary/

with ranked as (
    select
        id,
        company,
        salary,
        count(1) over(partition by company) as cnt,
        rank() over(partition by company order by salary) as rnk
    from Employee
)

select id, company, salary from (
    select *, row_number() over(partition by company, salary order by id) as rw
    from ranked
    where
        case
        when mod(cnt, 2) = 1 then rnk = round(cnt / 2)
        else rnk in (cnt / 2, cnt / 2 + 1)
        end
) s where rw = 1;

-- without window functions


with ord as (
    select *
    from Employee
    order by company, id, salary
)

select * from ord