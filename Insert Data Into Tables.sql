/* =========================================
   INSERT DATA INTO customers
   ========================================= */

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Amit Sharma', 'Delhi'),
(2, 'Neha Verma', 'Mumbai'),
(3, 'Rahul Singh', 'Bangalore'),
(4, 'Priya Patel', 'Ahmedabad'),
(5, 'Ankit Gupta', 'Delhi'),
(6, 'Sneha Iyer', 'Chennai'),
(7, 'Rohit Mehta', 'Pune');


/* =========================================
   INSERT DATA INTO products
   ========================================= */

INSERT INTO products (product_id, product_name, category, price) VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile Phone', 'Electronics', 25000),
(103, 'Headphones', 'Electronics', 3000),
(104, 'Office Chair', 'Furniture', 7000),
(105, 'Study Table', 'Furniture', 12000),
(106, 'Water Bottle', 'Accessories', 500),
(107, 'Backpack', 'Accessories', 2000);


/* =========================================
   INSERT DATA INTO orders
   ========================================= */

INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(1001, 1, 101, 1, '2024-01-10'),
(1002, 2, 102, 2, '2024-01-12'),
(1003, 3, 103, 3, '2024-01-15'),
(1004, 4, 104, 1, '2024-02-01'),
(1005, 5, 105, 1, '2024-02-05'),
(1006, 6, 106, 5, '2024-02-10'),
(1007, 7, 107, 2, '2024-02-15'),
(1008, 1, 102, 1, '2024-03-01'),
(1009, 2, 103, 2, '2024-03-05'),
(1010, 3, 101, 1, '2024-03-10'),
(1011, 4, 107, 3, '2024-03-15'),
(1012, 5, 106, 4, '2024-03-20');
