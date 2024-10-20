-- https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company-ii/description/


with cte as (
    select
        a.*,
        sum(a.salary) over win as cum_spent
    from candidates a
    window win as (
        partition by a.experience 
        order by a.salary
        rows between unbounded preceding and current row
    )
),
seniors as (
    select employee_id, cum_spent
    from cte 
    where experience = 'Senior' and cum_spent <= 70000
),
juniors as (
    select employee_id
    from cte
    where experience = 'Junior' and cum_spent <= 70000 - (select coalesce(max(cum_spent), 0) from seniors)
)

select employee_id from seniors union
select * from juniors;
