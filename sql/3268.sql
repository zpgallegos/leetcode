-- https://leetcode.com/problems/find-overlapping-shifts-ii/description/

with ovr as (
    select
        a.employee_id,
        a.start_time,
        timestampdiff(second, b.start_time, a.end_time) as overlap_duration
    from employeeshifts a
        inner join employeeshifts b on a.employee_id = b.employee_id
    where
        1=1
        and a.start_time < b.start_time
        and b.start_time < a.end_time
),
ttl as (
    select
        a.employee_id,
        sum(a.overlap_duration) / 60 as total_overlap_duration
    from ovr a
    group by 1
),
tab as (
    select
        s.employee_id,
        max(s.n_overlaps) + 1 as max_overlapping_shifts
    from (
        select
            a.employee_id,
            a.start_time,
            count(1) as n_overlaps
        from ovr a
        group by 1, 2
    ) s
    group by 1
),
res as (
    select
        a.employee_id,
        a.max_overlapping_shifts,
        b.total_overlap_duration
    from tab a
        inner join ttl b on a.employee_id = b.employee_id
),
res_filled as(
    select * from res

    union

    select distinct employee_id, 1, 0
    from employeeshifts
    where employee_id not in(select employee_id from res)
)

select * from res_filled order by employee_id;