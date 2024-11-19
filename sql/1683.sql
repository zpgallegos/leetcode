-- https://leetcode.com/problems/invalid-tweets/description/

select tweet_id from tweets where length(content) > 15;