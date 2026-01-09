/* =====================================================
   MINI SQL PROJECT – DATA ANALYTICS
   Tables: customers, products, orders
   ===================================================== */

-- Q1. Count total customers
SELECT COUNT(customer_name) 
FROM customers;


-- Q2. Count products by category
SELECT category, COUNT(product_name) 
FROM products 
GROUP BY category;


-- Q3. Count total orders
SELECT COUNT(ORDER_ID) 
FROM ORDERS;


-- Q4. Calculate total revenue per product
SELECT product_name,
       (p.price * o.quantity) AS 'Total_revenue'
FROM ORDERS o 
JOIN products p 
ON o.product_id = p.product_id;


-- Q5. Find average price of products
SELECT avg(price) 
FROM products;


-- Q6. Find maximum and minimum product price
SELECT MAX(price), Min(price) 
FROM products;


-- Q7. List distinct customer cities
SELECT DISTINCT city 
FROM customers;


-- Q8. Fetch orders for customer_id = 7
SELECT * 
FROM orders 
WHERE customer_id = 7;

-- Q9. Fetch products under Electronics category
SELECT * 
FROM products 
WHERE category = 'Electronics';

-- HELLO World