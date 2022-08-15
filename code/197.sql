

select b.id
from Weather a, Weather b
where datediff(b.recordDate, a.recordDate) = 1 and a.temperature < b.temperature;