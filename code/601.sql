insert into leetcode.Stadium values
(1, '2017-01-01', 10),
(2, '2017-01-02', 109),
(3, '2017-01-03', 150),
(4, '2017-01-04', 99),
(5, '2017-01-05', 145),
(6, '2017-01-06', 1455),
(7, '2017-01-07', 199),
(8, '2017-01-09', 188);
(9, '2017-01-10', 101);

select
	sub.id,
    sub.visit_date,
    sub.people

from (
	select
		id,
		visit_date,
		people,
		lead(id, 1) over(order by id) as lead_1,
		lead(id, 2) over(order by id) as lead_2,
		lag(id, 1) over(order by id) as lag_1,
		lag(id, 2) over(order by id) as lag_2
		
	from Stadium

    where people >= 100
    ) sub

where
    -- lookahead
    (id + 1 = lead_1 and id + 2 = lead_2) or
    -- middle
    (id - 1 = lag_1 and id + 1 = lead_1) or
    -- lookbehind
    (id - 1 = lag_1 and id - 2 = lag_2);