-- https://leetcode.com/problems/npv-queries/description/

select a.id, a.year, coalesce(b.npv, 0) as npv
from queries a left join npv b on a.id = b.id and a.year = b.year;