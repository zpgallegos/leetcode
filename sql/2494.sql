-- https://leetcode.com/problems/merge-overlapping-events-in-the-same-hall/

with cte as (
	select
		a.*,
        min(a.start_day) over win as curr_start,
		max(a.end_day) over win as curr_end
	from hallevents a
	window win as (
		partition by a.hall_id 
		order by a.start_day, a.end_day
		rows between unbounded preceding and current row
	)
),
incr as (
    select
        a.*,
        case when a.start_day <= lag(a.curr_end, 1) over win then 0 else 1 end as incr
    from cte a
    window win as (partition by a.hall_id order by a.start_day, a.end_day)
),
grpd as (
    select
        a.*,
        sum(a.incr) over win as grp
    from incr a
	window win as (
		partition by a.hall_id 
		order by a.start_day, a.end_day
		rows between unbounded preceding and current row
	)
)

select
    a.hall_id,
    min(a.start_day) as start_day,
    max(a.end_day) as end_day
from grpd a
group by a.hall_id, a.grp
order by 1, 2, 3;
