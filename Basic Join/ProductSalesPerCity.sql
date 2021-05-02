/*
Product Sales Per City

Problem set: see the Product Sales Per City Problem.pdf
*/

SELECT c.city_name, p.product_name, SUM(itm.line_total_price)
FROM invoice i JOIN invoice_item itm ON i.id = itm.invoice_id
                JOIN product p ON itm.product_id = p.id 
                JOIN customer cs ON i.customer_id = cs.id
                JOIN city c ON cs.city_id = c.id             
GROUP BY c.city_name, p.product_name
ORDER BY SUM(itm.line_total_price) DESC, c.city_name, p.product_name;
