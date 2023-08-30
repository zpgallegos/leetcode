

select sub.employee_id from (
    select a.employee_id
    from Employees a left join Salaries b on a.employee_id = b.employee_id
    where b.employee_id is null

    union

    select a.employee_id
    from Salaries a left join Employees b on a.employee_id = b.employee_id
    where b.employee_id is null

) sub
order by sub.employee_id;


