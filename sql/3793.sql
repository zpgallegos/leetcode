-- https://leetcode.com/problems/find-users-with-high-token-usage/

select
    user_id,
    count(1) as prompt_count,
    round(avg(tokens), 2) as avg_tokens
from prompts
group by user_id
having
    count(1) >= 3
    and count(distinct tokens) > 1
order by 3 desc, 1;