/* =========================================
   TABLE: customers
   Stores customer master data
   ========================================= */

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city          VARCHAR(50)
);


/* =========================================
   TABLE: products
   Stores product catalog information
   ========================================= */

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(50),
    category     VARCHAR(50),
    price        DECIMAL(10,2)
);


/* =========================================
   TABLE: orders
   Stores transactional order data
   ========================================= */

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,
    customer_id INT,
    product_id  INT,
    quantity    INT,
    order_date  DATE
);
