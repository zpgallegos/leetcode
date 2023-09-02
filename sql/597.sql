-- https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/

select coalesce(
    round((
        select count(distinct requester_id, accepter_id)
        from requestaccepted
        ) / (
        select count(distinct sender_id, send_to_id)
        from friendrequest
        ), 
    2), 0) as accept_rate