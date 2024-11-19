-- https://leetcode.com/problems/daily-leads-and-partners/


select
    a.date_id,
    a.make_name,
    count(distinct a.lead_id) as unique_leads,
    count(distinct a.partner_id) as unique_partners
from dailysales a
group by 1, 2;