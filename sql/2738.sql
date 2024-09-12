-- https://leetcode.com/problems/count-occurrences-in-text/

select 'bull' as word, (select count(1) from files where content like '% bull %') as count union
select 'bear' as word, (select count(1) from files where content like '% bear %') as count;

-- postgres regex
select 'bull' as word, (select count(1) from files where content ~ ' bull ') as count union
select 'bear' as word, (select count(1) from files where content ~ ' bear ') as count;