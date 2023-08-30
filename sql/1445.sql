

with apples as (
    select sale_date, sold_num as apple_count
    from Sales
    where fruit = 'apples'
), oranges as (
    select a.*, s.orange_count
    from apples a left join (
        select sale_date, sold_num as orange_count
        from Sales
        where fruit = 'oranges'
    ) s on a.sale_date = s.sale_date
)

select sale_date, apple_count - orange_count as diff
from oranges;