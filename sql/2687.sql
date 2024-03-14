-- https://leetcode.com/problems/bikes-last-time-used/description/

select * from (
    select bike_number, max(end_time) as end_time
    from bikes
    group by bike_number
) sub order by end_time desc;