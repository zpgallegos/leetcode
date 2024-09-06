-- https://leetcode.com/problems/consecutive-available-seats-ii/description/

with cte as (
    select
        a.*,
        lag(a.free, 1) over(order by a.seat_id) as last_free
    from cinema a
),
grpd as (
    select
        s.*,
        sum(s.incr) over win as grp
    from (
        select
            a.*,
            if(not(a.free = 1 and a.last_free = 1), 1, 0) as incr
        from cte a
    ) s
    window win as (order by s.seat_id rows between unbounded preceding and current row)
),
aggd as (
    select
        a.grp,
        min(a.seat_id) as first_seat_id,
        max(a.seat_id) as last_seat_id,
        count(1) as consecutive_seats_len
    from grpd a
    where a.free = 1
    group by 1
)

select first_seat_id, last_seat_id, consecutive_seats_len
from aggd
where consecutive_seats_len = (select max(consecutive_seats_len) from aggd)
order by 1;


-- https://leetcode.com/problems/consecutive-available-seats-ii/


with cte as (
    select
        *,
        case
        when free = 1 and (lag(free, 1) over win) = 0 then 1
        else 0
        end as chg
    from cinema
    window win as (order by seat_id)
), grps as (
    select *, sum(chg) over(order by seat_id) as grp
    from cte
    where free = 1
), grp_counts as (
    select grp, count(1) as grp_cnt
    from grps
    group by grp
)

select 
    min(seat_id) as first_seat_id,
    max(seat_id) as last_seat_id,
    count(1) as consecutive_seats_len
from grps
group by grp
having count(1) = (select max(grp_cnt) from grp_counts)
order by first_seat_id;