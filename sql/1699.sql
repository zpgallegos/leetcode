


select
    from_id as person1,
    to_id as person2,
    count(1) as call_count,
    sum(duration) as total_duration

from (
    select *
    from Calls
    where from_id < to_id

    union all

    select to_id as from_id, from_id as to_id, duration
    from Calls
    where from_id > to_id
) sub

group by from_id, to_id;