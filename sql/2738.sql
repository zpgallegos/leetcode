-- https://leetcode.com/problems/count-occurrences-in-text/

select 'bull' as word, count(distinct file_name) as "count"
from files
where content regexp ' bull '

union

select 'bear' as word, count(distinct file_name) as "count"
from files
where content regexp ' bear ';