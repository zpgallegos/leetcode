-- https://leetcode.com/problems/form-a-chemical-bond/

select a.symbol as metal, b.symbol as nonmetal
from elements a cross join elements b
where a.type = 'Metal' and b.type = 'Nonmetal';