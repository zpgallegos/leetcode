-- https://leetcode.com/problems/count-artist-occurrences-on-spotify-ranking-list/description/

select
    a.artist,
    count(1) as occurrences
from spotify a
group by 1
order by 2 desc, 1;