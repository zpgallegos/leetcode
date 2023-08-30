-- https://leetcode.com/problems/dynamic-unpivoting-of-a-table/
SELECT
    product_id,
    'LC_Store' AS Store,
    LC_Store AS price
FROM
    Prods
WHERE
    LC_Store IS NOT NULL;

delimiter / / CREATE PROCEDURE UnpivotProducts() BEGIN
SET
    SESSION group_concat_max_len = 1000000;

SET
    @sql = NULL;

SELECT
    GROUP_CONCAT(
        concat(
            'select product_id, ''',
            store,
            ''' as store, ',
            store,
            ' as price from products where ',
            store,
            ' is not null'
        ) SEPARATOR ' union '
    ) INTO @sql
FROM
    (
        SELECT
            column_name AS store
        FROM
            information_schema.columns
        WHERE
            table_name = 'products'
            AND column_name != 'product_id'
    ) s;

prepare qry
FROM
    @sql;

EXECUTE qry;

deallocate prepare qry;

END / / delimiter;

Error Code: 1064 You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'END / / delimiter' at line 1

select product_id, 'LC_Store' as store, LC_Store as price from prods where LC_Store is not null union select product_id, 'Nozama' as store, Nozama as price from prods where Nozama is not null union select product_id, 'Shop' as store, Shop as price from prods where Shop is not null union select product_id, 'Souq' as store, Souq as price from prods where Souq is not null
