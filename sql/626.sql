-- https://leetcode.com/problems/exchange-seats/

select
    a.id,
    coalesce(b.student, a.student) as student

from Seat a
    left join Seat b on (case when mod(a.id, 2) = 1 then a.id + 1 else a.id - 1 end) = b.id