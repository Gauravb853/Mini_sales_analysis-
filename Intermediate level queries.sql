/* ================= INTERMEDIATE QUERIES ================= */

-- Q10. Total price of products per category
SELECT category, sum(price) 
FROM products 
GROUP BY category;


-- Q11. Count how many times each product was ordered
SELECT count(o.product_id), p.product_name 
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY p.product_name;


-- Q12. Total revenue per product
SELECT sum(p.price), p.product_name 
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY p.product_name;


-- Q13. City-wise revenue
SELECT city, 
       sum(o.quantity * p.price) Revenue 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY city;


-- Q14. Customer-wise revenue
SELECT customer_name, 
       sum(o.quantity * p.price) Revenue 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY customer_name;


-- Q15. Order count per customer
SELECT customer_name, 
       count(o.order_id) AS 'Order count' 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id 
GROUP BY c.customer_id;


-- Q16. Top 5 products by quantity sold
SELECT p.product_name, 
       sum(o.quantity) 
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY o.product_id, p.product_name 
ORDER BY sum(o.quantity) DESC 
LIMIT 5;


-- Q17. Top 5 customers by revenue
SELECT customer_name, 
       sum(o.quantity * p.price) AS ttl 
FROM orders o 
JOIN customers c 
ON o.customer_id = c.customer_id  
JOIN products p 
ON o.product_id = p.product_id  
GROUP BY o.customer_id 
ORDER BY ttl DESC 
LIMIT 5;


-- Q18. Average Order Value (AOV)
SELECT ROUND(AVG(revenue),1) AOV  
FROM (
    SELECT o.order_id, 
           sum(o.quantity * p.price) revenue 
    FROM orders o 
    JOIN products p 
    ON o.product_id = p.product_id 
    GROUP BY order_id
) t;


-- Q19. Monthly revenue trend with increase/decrease
SELECT *, 
       LAG(Revenue) OVER(ORDER BY month) AS 'prev_mnth',
       Revenue - LAG(Revenue) OVER(ORDER BY month) AS Chng_in_sale,
       CASE
           WHEN Revenue > LAG(Revenue) OVER (ORDER BY month) THEN 'Increase'
           WHEN Revenue < LAG(Revenue) OVER (ORDER BY month) THEN 'Decrease'
           ELSE 'No change'
       END AS trend
FROM (
    SELECT sum(quantity * price) AS Revenue,
           date_format(order_date,'%Y-%m') AS month 
    FROM orders o 
    JOIN products p 
    ON o.product_id = p.product_id 
    GROUP BY date_format(order_date,'%Y-%m')
) t;