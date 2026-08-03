-- https://leetcode.com/problems/find-students-with-study-spiral-pattern/

with base as (
    select
        *,
        row_number() over win as rn,
        session_date - lag(session_date, 1) over win as days_since_last_session
    from study_sessions
    window win as (partition by student_id order by session_date, session_id)
),

candidate_lengths as (
    select
        a.student_id,
        min(b.rn - a.rn) as cycle_length -- assumes single length cycle consideration
    from base a
    inner join base b on
        a.rn = 1
        and a.rn < b.rn
        and a.student_id = b.student_id
        and a.subject = b.subject
    group by 1
    having min(b.rn - a.rn) >= 3
),

grouped as (
    select
        a.student_id,
        a.session_date,
        a.days_since_last_session,
        a.subject,
        a.hours_studied,
        b.cycle_length,
        a.rn,
        mod(a.rn - 1, b.cycle_length) as subject_grp
    from base a
    inner join candidate_lengths b on a.student_id = b.student_id
),

qual as (
    select
        student_id,
        min(cycle_length) as cycle_length,
        sum(hours_studied) as total_study_hours
    from grouped
    group by student_id
    having
        count(1) >= 2 * min(cycle_length)
        and max(days_since_last_session) <= 2
        and count(distinct subject) = min(cycle_length)
        and count(distinct (subject_grp, subject)) = count(distinct subject)
)

select
    a.student_id,
    b.student_name,
    b.major,
    a.cycle_length,
    a.total_study_hours
from qual a
inner join students b on a.student_id = b.student_id
order by 4 desc, 5 desc;
