-- https://leetcode.com/problems/tasks-count-in-the-weekend/
SELECT
    sum(weekday(submit_date) IN (5, 6)) AS weekend_cnt,
    sum(weekday(submit_date) NOT IN (5, 6)) AS working_cnt
FROM
    Tasks