-- https://leetcode.com/problems/classifying-triangles-by-lengths/description/


select
    case
    when a + b <= c or b + c <= a or a + c <= b then 'Not A Triangle'
    else
        case
        when a = b and a = c then 'Equilateral'
        when a = b or a = c or b = c then 'Isosceles'
        else 'Scalene'
        end
    end as triangle_type
from triangles;