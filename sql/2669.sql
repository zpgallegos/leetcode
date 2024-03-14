-- https://leetcode.com/problems/count-artist-occurrences-on-spotify-ranking-list/description/

select * from (
    select artist, count(1) as occurrences
    from spotify
    group by artist
) sub order by occurrences desc, artist;