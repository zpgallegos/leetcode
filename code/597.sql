-- https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/

with a as (
    select distinct sender_id, send_to_id
    from friendrequest
), b as (
    select distinct requester_id, accepter_id
    from requestaccepted
)

select coalesce(round(sum(b.requester_id is not null) / count(1), 2), 0) as accept_rate
from a left join b on a.sender_id = b.requester_id and a.send_to_id = b.accepter_id