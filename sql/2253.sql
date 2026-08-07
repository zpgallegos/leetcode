-- https://leetcode.com/problems/dynamic-unpivoting-of-a-table/description/


create procedure UnpivotProducts()
begin
    set session group_concat_max_len = 1000000;
    set @sql = null;

    select group_concat(
        concat(
            'select product_id, ''', 
            column_name, 
            ''' as store, ',
            column_name,
            ' as price from products where ',
            column_name,
            ' is not null'
        )
        separator ' union '
    ) into @sql
    from information_schema.columns
    where 
        1=1
        and table_schema = 'test'
        and table_name = 'products' 
        and column_name != 'product_id';
    
    prepare qry from @sql;
    execute qry;
    deallocate prepare qry;
end

-- PostgreSQL
-- Turning each row into JSON allows the store columns to remain dynamic.
select
    p.product_id,
    u.store,
    u.price::text::integer as price
from products as p
cross join lateral jsonb_each(to_jsonb(p) - 'product_id') as u(store, price)
where u.price <> 'null'::jsonb;