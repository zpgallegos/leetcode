-- https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/


with seqd as (
    select
        log_id,
        lag(log_id, 1) over w as lg,
        lead(log_id, 1) over w as ld
    from Logs
    window w as (order by log_id)
), cat as (
    select
        *,
        if(lg is null or lg != log_id - 1, 1, 0) as is_start,
        if(ld is null or ld != log_id + 1, 1, 0) as is_end
    from seqd
)

select a.log_id as start_id, b.log_id as end_id
from (
    select log_id, row_number() over(order by log_id) as rw
    from cat
    where is_start
) a inner join (
    select log_id, row_number() over(order by log_id) as rw
    from cat
    where is_end
) b on a.rw = b.rw

-- 

with tbl as (
    select
        log_id,
        -- this calculation makes it so that continuous sequences all have the same diff value
        log_id - row_number() over(order by log_id) as diff
    from Logs
)

select min(log_id) as start_id, max(log_id) as end_id
from tbl
group by diff
    

