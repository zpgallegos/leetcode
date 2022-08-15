
select a.name, sum(b.amount) as balance
from Users a inner join Transactions b on a.account = b.account
group by a.account
having sum(b.amount) > 10000;