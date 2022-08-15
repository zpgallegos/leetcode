-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/


select * from (
    select
        reports_to as employee_id,
        s.name,
        count(1) as reports_count,
        round(avg(age)) as average_age

    from Employees a
        inner join (
            select distinct employee_id, name
            from Employees
        ) s on a.reports_to = s.employee_id

    group by 1, 2
) q order by 1;