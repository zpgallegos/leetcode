-- https://leetcode.com/problems/find-overlapping-shifts-ii/description/

with emps as (
    select distinct a.employee_id
    from employeeshifts a
),
overlaps as (
    select
        a.employee_id,
        a.start_time as orig_start,
        a.end_time as orig_end,
        b.start_time as overlap_start,
        b.end_time as overlap_end
    from employeeshifts a
        inner join employeeshifts b on a.employee_id = b.employee_id
    where
        a.start_time < b.start_time and
        b.start_time < a.end_time
),
max_overlaps as (
    select
        sub.employee_id,
        max(sub.overlaps) + 1 as max_overlapping_shifts
    from (
        select
            a.employee_id,
            a.orig_start,
            count(1) as overlaps
        from overlaps a
        group by 1, 2
    ) sub
    group by 1
),
max_overlaps_filled as (
    select * from max_overlaps 
    
    union
    
    select employee_id, 1 as max_overlapping_shifts 
    from emps 
    where employee_id not in(select employee_id from max_overlaps)
),
duration as (
    select
        a.employee_id,
        sum(timestampdiff(second, a.overlap_start, a.orig_end)) / 60 as total_overlap_duration
    from overlaps a
    group by 1
),
duration_filled as (
    select * from duration

    union

    select employee_id, 0 as total_overlap_duration
    from emps
    where employee_id not in(select employee_id from duration)
)

select
    a.employee_id,
    a.max_overlapping_shifts,
    b.total_overlap_duration
from max_overlaps_filled a
    inner join duration_filled b on a.employee_id = b.employee_id
order by 1;