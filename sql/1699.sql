-- https://leetcode.com/problems/number-of-calls-between-two-persons/description/


with cte as (
    select
        case when from_id < to_id then from_id else to_id end as person1,
        case when from_id < to_id then to_id else from_id end as person2,
        duration
    from calls
)

select
    person1,
    person2,
    count(1) as call_count,
    sum(duration) as total_duration
from cte
group by 1, 2;
