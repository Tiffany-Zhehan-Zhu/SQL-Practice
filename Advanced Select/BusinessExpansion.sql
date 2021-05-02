/*
Business Expansion

Problem set: see the Business Expansion Problem.pdf

*/

SELECT u.id, u.first_name, u.last_name, cs.id, cs.customer_name, COUNT(*)
FROM contact ct JOIN customer cs ON ct.customer_id = cs.id
                 JOIN user_account u ON ct.user_account_id = u.id 
WHERE (user_account_id, customer_id) IN 
        (SELECT user_account_id, customer_id
        FROM contact
        GROUP BY user_account_id, customer_id
        HAVING COUNT(*)>1)
GROUP BY u.id, u.first_name, u.last_name, cs.id, cs.customer_name
ORDER BY u.id;
