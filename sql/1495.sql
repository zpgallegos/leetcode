-- https://leetcode.com/problems/friendly-movies-streamed-last-month/description/


select distinct b.title
from tvprogram a inner join content b on a.content_id = b.content_id
where
    b.kids_content = 'Y' and
    b.content_type = 'Movies' and
    a.program_date between '2020-06-01' and '2020-06-30';