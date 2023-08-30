-- https://leetcode.com/problems/unpopular-books/

with bs as (
    select *
    from books
    where available_from < date_sub('2019-06-23', interval 1 month)
), ords as (
    select book_id, sum(quantity) as sold
    from orders
    where dispatch_date >= date_sub('2019-06-23', interval 1 year)
    group by book_id
)

select bs.book_id, bs.name
from bs left join ords on bs.book_id = ords.book_id
where ords.book_id is null or ords.sold < 10;