-- https://leetcode.com/problems/calculate-compressed-mean/

select round(
    sum(item_count * order_occurrences) / cast(sum(order_occurrences) as float)
    , 2) as average_items_per_order
from orders;