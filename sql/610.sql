-- https://leetcode.com/problems/triangle-judgement/description/


select
    a.*,
    if(a.x + a.y <= a.z or a.x + a.z <= a.y or a.y + a.z <= a.x, 'No', 'Yes') as triangle
from triangle a;