-- https://leetcode.com/problems/dynamic-pivoting-of-a-table/
delimiter / / CREATE PROCEDURE PivotProducts() BEGIN
SET
    SESSION group_concat_max_len = 1000000;

SET
    @cols = NULL;

SELECT
    GROUP_CONCAT(
        DISTINCT concat(
            'max(if(store = ''',
            store,
            ''', price, null)) as ',
            store
        )
        ORDER BY
            store SEPARATOR ','
    ) INTO @cols
FROM
    products;

SET
    @sql = concat(
        'select product_id, ',
        @cols,
        ' from products group by product_id'
    );

prepare qry
FROM
    @sql;

EXECUTE qry;

deallocate prepare qry;

END / / delimiter;

