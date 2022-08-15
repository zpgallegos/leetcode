-- https://leetcode.com/problems/number-of-trusted-contacts-of-a-customer/
WITH contact_counts AS (
    SELECT
        a.customer_id,
        a.customer_name,
        count(b.user_id) AS contacts_cnt,
        count(c.email) AS trusted_contacts_cnt
    FROM
        Customers a
        LEFT JOIN Contacts b ON a.customer_id = b.user_id
        LEFT JOIN Customers c ON b.contact_email = c.email
    GROUP BY
        a.customer_id,
        a.customer_name
)
SELECT
    a.invoice_id,
    b.customer_name,
    a.price,
    b.contacts_cnt,
    b.trusted_contacts_cnt
FROM
    invoices a
    INNER JOIN contact_counts b ON a.user_id = b.customer_id
ORDER BY
    a.invoice_id;