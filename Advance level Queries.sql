
-- Advance problems

-- 21 SELECT sum(price*quantity)AS spend,customer_name FROM orders o
-- JOIN products p ON o.product_id =p.product_id
-- JOIN customers c ON c.customer_id =o.customer_id
-- GROUP BY o.customer_id
-- HAVING sum(price*quantity) > (SELECT Avg(spend) as AVG FROM 
-- (SELECT sum(price*quantity)AS spend,customer_id  FROM orders o
-- JOIN products p ON o.product_id =p.product_id
-- GROUP BY customer_id 	 ) p)

-- 22 SELECT p.product_name,p.category,p.price FROM orders o RIGHT JOIN products p  ON o.product_id = p.product_id WHERE order_id IS NULL
-- 23 SELECT c.customer_name  FROM orders o JOIN customers c  on o.customer_id = c.customer_id GROUP BY o.customer_id,customer_name Having count(o.customer_id)>1

-- 24 SELECT sum(price*quantity)as Revenue,city  FROM products p JOIN orders o ON p.product_id = o.product_id JOIN customers c ON o.customer_id = c.customer_id GROUP BY city

-- 25 SELECT sum(p.price*o.quantity)as Revenue, category  FROM products p JOIN orders o ON p.product_id = o.product_id JOIN customers c ON o.customer_id = c.customer_id GROUP BY category

-- 26 SELECT sale,mnth FROM ( SELECT sum(p.price*o.quantity) as sale,date_format(order_date,'%Y-%m') as mnth FROM orders o JOIN products p ON o.product_id = p.product_id 
-- GROUP BY date_format(order_date,'%Y-%m')) y

-- 27 SELECT c.customer_name, sum(p.price*o.quantity) as Max_spent FROM orders o JOIN customers c ON o.customer_id = c.customer_id JOIN products P on o.product_id =p.product_id
 -- GROUP BY o.customer_id ORDER BY Max_spent desc
 
 -- 28 SELECT category, ctgy_rvn, ROUND( (ctgy_rvn/ttl_rvn)*100,2) as percentage FROM (
  -- Category_Revenue
 -- SELECT p.category,SUM(p.price*o.quantity) as ctgy_rvn, (SELECT sum(p.price*o.quantity) FROM orders o JOIN products p ON o.product_id = p.product_id ) as ttl_rvn   -- total revenue
 --  FROM orders o RIGHT JOIN products p ON o.product_id=p.product_id GROUP BY category) t

-- 29 SELECT c.customer_name,category FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN products p ON p.product_id = o.product_id WHERE o.product_id IN (104,105) OR o.product_id IN (101,102,103)

-- 30 SELECT o.product_id,sum(o.quantity) as tlt_qnty FROM orders o JOIN products p ON o.product_id =p.product_id GROUP BY o.product_id ORDER BY tlt_qnty DESC

-- Advance Questions

-- 31 SELECT RANK()over(order by Spending DESC) as Ranking,customer_name, Spending FROM (SELECT sum(quantity*price) as Spending, o.customer_id,c.customer_name FROM orders o
-- JOIN products p ON o.product_id =p.product_id JOIN customers c ON o.customer_id = c.customer_id group by o.customer_id) t

 -- 32 SELECT DENSE_RANK() OVER(ORDER BY qnty_sold desc) AS Dns_Rnk,product_name, qnty_sold FROM ( SELECT sum(quantity) as qnty_sold, p.product_name FROM orders o JOIN products p ON o.product_id =p.product_id
-- GROUP BY o.product_id ) t

-- 33 SELECT sum(mnth_rvn) OVER(ORDER BY Month1 ) AS Cumulative_revenue,Month1 FROM(SELECT sum(p.price*o.quantity) as mnth_rvn, date_format(o.order_date,'%Y-%m') AS Month1  from orders o 
-- JOIN products p ON o.product_id =p.product_id GROUP BY Month1 ) t

-- 34 SELECT AVG(revenue)as median FROM (
-- SELECT revenue, Row_number()over(order by revenue) as rn ,count(*) over() as cnt FROM (SELECT o.customer_id, SUM(p.price*o.quantity) as revenue, count(customer_id) as Even_Odd FROM orders o
-- JOIN products p ON o.product_id =p.product_id GROUP BY o.customer_id )t)y WHERE rn IN (Floor(cnt+1)/2, CEIL(cnt+1)/2)

-- 35 SELECT row_number()over(ORDER BY city_revenue DESC)as Top_Cities_Rank,city,city_revenue, rank() over(order by city_revenue) as Ranking FROM (SELECT sum(p.price*o.quantity)as city_revenue, c.city FROM orders o
-- JOIN products p ON o.product_id =p.product_id JOIN customers c ON o.customer_id = c.customer_id GROUP BY c.city )y

-- 36 SELECT category, CONCAT(Round((mnth_revenue/ttl_revenue)*100,2),'%') AS percentage FROM (SELECT p.category, sum(p.price*o.quantity) as mnth_revenue, sum(sum(p.price*o.quantity)) over() as ttl_revenue FROM orders o
-- JOIN products p ON o.product_id = p.product_id GROUP by p.category) t


-- 37 SELECT customer_id, CONCAT(Round((Per_customer_revenue/MAX(Per_customer_revenue)over())*100,2),'%') AS Customer_revenue_to_Top_selling_cx FROM 
-- (SELECT o.customer_id,sum(p.price*o.quantity) as Per_customer_revenue FROM orders o JOIN products p ON o.product_id = p.product_id GROUP by o.customer_id) y

-- 38 SELECT * FROM(SELECT customer_id, Customer_Revenue, percentage,sum(percentage)over(ORDER BY Customer_Revenue DESC) as Contri_Top50 
-- FROM (SELECT customer_id ,Customer_Revenue, Round((Customer_Revenue/ttl_Revenue)*100,2)as percentage FROM  (    
-- SELECT customer_id ,sum(p.price*o.quantity) as Customer_Revenue, sum(sum(p.price*o.quantity)) over() as ttl_Revenue FROM products p JOIN orders o ON p.product_id = o.product_id 
-- Group By o.customer_id) t)y)final WHERE Contri_Top50 <= 50

-- 39 SELECT month1,
 --    Current_mnth_revenue, 
   --  Previous_mnth, 
    -- (Current_mnth_revenue - Previous_mnth) as Difference , CONCAT(Round(((Current_mnth_revenue - Previous_mnth)/Previous_mnth)*100,2),'%') AS Growth_rate 
-- FROM (SELECT DATE_Format(order_date,'%Y-%m') AS month1 , SUM(p.price*o.quantity) AS Current_mnth_Revenue, 
  --     LAG(SUM(p.price*o.quantity)) OVER(ORDER BY DATE_Format(order_date,'%Y-%m')) as Previous_mnth 
    --   FROM orders o
      -- JOIN products p  ON o.product_id =p.product_id
     --  GROUP by DATE_Format(order_date,'%Y-%m')) t
     
  -- 40 SELECT  Round(AVG(Current_mnth_Revenue) OVER (ORDER BY month1 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) as ROlling_3mnth_avg  
--   FROM(SELECT DATE_Format(order_date,'%Y-%m') AS month1 , SUM(p.price*o.quantity) AS Current_mnth_Revenue FROM orders o JOIN products p  ON o.product_id =p.product_id
	--    GROUP by DATE_Format(order_date,'%Y-%m')) t