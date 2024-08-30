-- https://leetcode.com/problems/combine-two-tables/description/


select
    a.firstname,
    a.lastname,
    b.city,
    b.state
    
from person a
    left join address b on a.personid = b.personid;