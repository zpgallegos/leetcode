-- https://leetcode.com/problems/find-invalid-ip-addresses/description/

with

long as (
    select
        log_id,
        unnest(string_to_array(ip, '.')) as oct
    from logs
),

invalid_ids as (
    select log_id
    from long
    group by 1
    having
        count(1) != 4 or
        sum(case when oct::int2 > 255 then 1 else 0 end) > 0 or
        sum(case when oct ~ '^0\d' then 1 else 0 end) > 0
)

select a.ip, count(1) as invalid_count
from logs a
inner join invalid_ids b on a.log_id = b.log_id
group by 1
order by 2 desc, 1 desc;
