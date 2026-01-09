/* ================= ADVANCED QUERIES ================= */

-- Q20. Customers spending more than average
SELECT sum(price * quantity) AS spend,
       customer_name 
FROM orders o
JOIN products p 
ON o.product_id = p.product_id
JOIN customers c 
ON c.customer_id = o.customer_id
GROUP BY o.customer_id
HAVING sum(price * quantity) > (
    SELECT Avg(spend) 
    FROM (
        SELECT sum(price * quantity) AS spend,
               customer_id  
        FROM orders o
        JOIN products p 
        ON o.product_id = p.product_id
        GROUP BY customer_id
    ) p
);


-- Q21. Products that were never ordered
SELECT p.product_name,
       p.category,
       p.price 
FROM orders o 
RIGHT JOIN products p  
ON o.product_id = p.product_id 
WHERE order_id IS NULL;


-- Q22. Customers with more than one order
SELECT c.customer_name  
FROM orders o 
JOIN customers c  
ON o.customer_id = c.customer_id 
GROUP BY o.customer_id, customer_name 
HAVING count(o.customer_id) > 1;


-- Q23. City-wise revenue (duplicate validation)
SELECT sum(price * quantity) AS Revenue,
       city  
FROM products p 
JOIN orders o 
ON p.product_id = o.product_id 
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY city;


-- Q24. Category-wise revenue
SELECT sum(p.price * o.quantity) AS Revenue,
       category  
FROM products p 
JOIN orders o 
ON p.product_id = o.product_id 
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY category;


-- Q25. Monthly sales
SELECT sale,
       mnth 
FROM (
    SELECT sum(p.price * o.quantity) AS sale,
           date_format(order_date,'%Y-%m') AS mnth 
    FROM orders o 
    JOIN products p 
    ON o.product_id = p.product_id 
    GROUP BY date_format(order_date,'%Y-%m')
) y;


-- Q26. Customer maximum spending
SELECT c.customer_name,
       sum(p.price * o.quantity) AS Max_spent 
FROM orders o 
JOIN customers c 
ON o.customer_id = c.customer_id 
JOIN products p 
ON o.product_id = p.product_id
GROUP BY o.customer_id 
ORDER BY Max_spent DESC;


-- Q27. Category revenue percentage contribution
SELECT category,
       ctgy_rvn,
       ROUND((ctgy_rvn / ttl_rvn) * 100, 2) AS percentage 
FROM (
    SELECT p.category,
           SUM(p.price * o.quantity) AS ctgy_rvn,
           (SELECT sum(p.price * o.quantity) 
            FROM orders o 
            JOIN products p 
            ON o.product_id = p.product_id) AS ttl_rvn
    FROM orders o 
    RIGHT JOIN products p 
    ON o.product_id = p.product_id 
    GROUP BY category
) t;


-- Q28. Customers ordering specific product groups
SELECT c.customer_name,
       category 
FROM customers c 
JOIN orders o 
ON c.customer_id = o.customer_id 
JOIN products p 
ON p.product_id = o.product_id 
WHERE o.product_id IN (104,105) 
   OR o.product_id IN (101,102,103);


-- Q29. Product-wise total quantity sold
SELECT o.product_id,
       sum(o.quantity) AS tlt_qnty 
FROM orders o 
JOIN products p 
ON o.product_id = p.product_id 
GROUP BY o.product_id 
ORDER BY tlt_qnty DESC;


/* ================= WINDOW FUNCTIONS ================= */

-- Q30. Rank customers by spending
SELECT RANK() OVER(ORDER BY Spending DESC) AS Ranking,
       customer_name,
       Spending 
FROM (
    SELECT sum(quantity * price) AS Spending,
           o.customer_id,
           c.customer_name 
    FROM orders o
    JOIN products p 
    ON o.product_id = p.product_id 
    JOIN customers c 
    ON o.customer_id = c.customer_id 
    GROUP BY o.customer_id
) t;


-- Q31. Dense rank products by quantity sold
SELECT DENSE_RANK() OVER(ORDER BY qnty_sold DESC) AS Dns_Rnk,
       product_name,
       qnty_sold 
FROM (
    SELECT sum(quantity) AS qnty_sold,
           p.product_name 
    FROM orders o 
    JOIN products p 
    ON o.product_id = p.product_id
    GROUP BY o.product_id
) t;


-- Q32. Cumulative monthly revenue
SELECT sum(mnth_rvn) OVER(ORDER BY Month1) AS Cumulative_revenue,
       Month1 
FROM (
    SELECT sum(p.price * o.quantity) AS mnth_rvn,
           date_format(o.order_date,'%Y-%m') AS Month1  
    FROM orders o 
    JOIN products p 
    ON o.product_id = p.product_id 
    GROUP BY Month1
) t;


-- Q33. Median customer revenue
SELECT AVG(revenue) AS median 
FROM (
    SELECT revenue,
           Row_number() OVER(ORDER BY revenue) AS rn,
           count(*) OVER() AS cnt 
    FROM (
        SELECT o.customer_id,
               SUM(p.price * o.quantity) AS revenue,
               count(customer_id) AS Even_Odd 
        FROM orders o
        JOIN products p 
        ON o.product_id = p.product_id 
        GROUP BY o.customer_id
    ) t
) y 
WHERE rn IN (FLOOR(cnt+1)/2, CEIL(cnt+1)/2);

-- Q34. Rank cities by revenue and also show ranking using RANK()
SELECT 
    ROW_NUMBER() OVER (ORDER BY city_revenue DESC) AS Top_Cities_Rank,
    city,
    city_revenue,
    RANK() OVER (ORDER BY city_revenue) AS Ranking
FROM (
    SELECT 
        SUM(p.price * o.quantity) AS city_revenue,
        c.city
    FROM orders o
    JOIN products p 
        ON o.product_id = p.product_id
    JOIN customers c 
        ON o.customer_id = c.customer_id
    GROUP BY c.city
) y;


-- Q35. Category-wise revenue contribution percentage
SELECT 
    category,
    CONCAT(ROUND((mnth_revenue / ttl_revenue) * 100, 2), '%') AS percentage
FROM (
    SELECT 
        p.category,
        SUM(p.price * o.quantity) AS mnth_revenue,
        SUM(SUM(p.price * o.quantity)) OVER() AS ttl_revenue
    FROM orders o
    JOIN products p 
        ON o.product_id = p.product_id
    GROUP BY p.category
) t;


-- Q36. Customer revenue compared to top-spending customer
SELECT 
    customer_id,
    CONCAT(
        ROUND(
            (Per_customer_revenue / MAX(Per_customer_revenue) OVER()) * 100,
        2),
    '%') AS Customer_revenue_to_Top_selling_cx
FROM (
    SELECT 
        o.customer_id,
        SUM(p.price * o.quantity) AS Per_customer_revenue
    FROM orders o
    JOIN products p 
        ON o.product_id = p.product_id
    GROUP BY o.customer_id
) y;


-- Q37. Identify customers contributing to top 50% of revenue (Pareto analysis)
SELECT *
FROM (
    SELECT 
        customer_id,
        Customer_Revenue,
        percentage,
        SUM(percentage) OVER (ORDER BY Customer_Revenue DESC) AS Contri_Top50
    FROM (
        SELECT 
            customer_id,
            Customer_Revenue,
            ROUND((Customer_Revenue / ttl_Revenue) * 100, 2) AS percentage
        FROM (
            SELECT 
                customer_id,
                SUM(p.price * o.quantity) AS Customer_Revenue,
                SUM(SUM(p.price * o.quantity)) OVER() AS ttl_Revenue
            FROM products p
            JOIN orders o 
                ON p.product_id = o.product_id
            GROUP BY o.customer_id
        ) t
    ) y
) final
WHERE Contri_Top50 <= 50;


-- Q38. Month-over-month revenue growth rate
SELECT 
    month1,
    Current_mnth_revenue,
    Previous_mnth,
    (Current_mnth_revenue - Previous_mnth) AS Difference,
    CONCAT(
        ROUND(
            ((Current_mnth_revenue - Previous_mnth) / Previous_mnth) * 100,
        2),
    '%') AS Growth_rate
FROM (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month1,
        SUM(p.price * o.quantity) AS Current_mnth_Revenue,
        LAG(SUM(p.price * o.quantity)) 
            OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS Previous_mnth
    FROM orders o
    JOIN products p 
        ON o.product_id = p.product_id
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) t;


-- Q39. Rolling 3-month average revenue
SELECT 
    ROUND(
        AVG(Current_mnth_Revenue) 
        OVER (ORDER BY month1 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
    2) AS Rolling_3mnth_avg
FROM (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month1,
        SUM(p.price * o.quantity) AS Current_mnth_Revenue
    FROM orders o
    JOIN products p 
        ON o.product_id = p.product_id
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
) t;