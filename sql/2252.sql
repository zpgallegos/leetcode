-- https://leetcode.com/problems/dynamic-pivoting-of-a-table/description/

create procedure PivotProducts()
begin
    set session group_concat_max_len = 1000000;
    set @sql = null;

    with stores as (
        select distinct store from products
    )

    select
        group_concat(
            concat('max(case when store = ''', store, ''' then price else null end) as ', store)
        order by store separator ','
        ) into @sql
    from stores;

    set @qry = concat('select product_id, ', @sql, ' from products group by product_id');

    prepare query from @qry;
    execute query;
    deallocate prepare query;
end

