-- https://leetcode.com/problems/invalid-tweets-ii/

select tweet_id
from tweets
where
    length(content) > 140 or
    length(replace(content, '@', '')) < length(content) - 3 or
    length(replace(content, '#', '')) < length(content) - 3
order by tweet_id;