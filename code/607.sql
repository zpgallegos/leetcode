select
    distinct name
from
    SalesPerson a
where
    name not in (
        select
            distinct s.name
        from
            Orders o
            inner join Company c on o.com_id = c.com_id
            inner join SalesPerson s on o.sales_id = s.sales_id
        where
            c.name = 'RED'
    );

select
    distinct name
from
    SalesPerson a
where
    name not in (
        select
            distinct s.name
        from
            Orders o
            inner join Company c on o.com_id = c.com_id
            inner join SalesPerson s on o.sales_id = s.sales_id
        where
            c.name = 'RED'
    );