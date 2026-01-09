-- Medium problems (intermediate)

-- 11 SELECT category,sum(price) from products Group by category

-- 12 SELECT count(o.product_id),p.product_name from orders o JOIN products p on o.product_id = p.product_id group by p.product_name

-- 13 SELECT sum(p.price),p.product_name from orders o JOIN products p on o.product_id = p.product_id group by p.product_name

-- 14 SELECT city, sum(o.quantity*p.price) Revenue FROM customerS c JOIN orders o ON c.customer_id= o.customer_id JOIN products p ON o.product_id= p.product_id GROUP BY city

-- 15 SELECT customer_name, sum(o.quantity*p.price) Revenue FROM customerS c JOIN orders o ON c.customer_id= o.customer_id JOIN products p ON o.product_id= p.product_id GROUP BY customer_name

-- 16 SELECT customer_name, count(o.order_id) as 'Order count' FROM customerS c JOIN orders o ON c.customer_id= o.customer_id GROUP BY c.customer_id

-- 17 SELECT p.product_name, sum(o.quantity) FROM orders o JOIN products p on o.product_id =p.product_id group by o.product_id,p.product_name Order BY sum(o.quantity) desc Limit 5

-- 18 SELECT customer_name, sum(o.quantity*p.price) as ttl FROM orders o JOIN customers c ON o.customer_id= c.customer_id  JOIN products p on o.product_id =p.product_id  Group By o.customer_id Order BY ttl desc Limit 5

-- 19 SELECT ROUND(AVG(revenue),1) AOV  FROM (SELECT o.order_id, sum(o.quantity*p.price) revenue FROM orders o JOIN products p ON o.product_id = p.product_id GROUP BY order_id) t

-- 20 SELECT *, LAG(Revenue) OVER(order by month) AS 'prev_mnth' , Revenue - LAG(Revenue) OVER(order by month) AS Chng_in_sale,
 -- CASE
  --  WHEN Revenue > LAG(Revenue) OVER (ORDER BY month) THEN 'Increase'
   -- WHEN Revenue < LAG(Revenue) OVER (ORDER BY month) THEN 'Decrease'
   -- ELSE 'No change' END AS trend
 -- FROM (SELECT sum(quantity*price) as Revenue, date_format(order_date,'%Y-%m') AS month FROM orders o JOIN products p ON o.product_id= p.product_id GROUP BY date_format(order_date,'%Y-%m')
-- ) t
