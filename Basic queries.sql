
-- 2 SELECT count(customer_name) from customers

-- 3 SELECT category, COUNT(product_name) from products group by category

-- 4 SELECT COUNT(ORDER_ID) FROM ORDERS

-- 5 SELECT product_name,(p.price * o.quantity) as 'Total_revenue'  FROM ORDERS o JOIN products p ON o.product_id = p.product_id

-- 6 SELECT avg(price) FROM products

-- 7 SELECT MAX(price), Min(price) FROM products
-- 8 SELECT DISTINCT city FROM customers

-- 9 SELECT * from orders where customer_id =7 

-- 10 SELECT * from products where category ='Electronics' 
