-- ============================================
-- Sql project
-- TOPIC: ONE TO MANY RELATIONSHIP (1:M)
-- ============================================


-- Creating Parent Table: Products

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category TEXT,
    price NUMERIC(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    added_on DATE
);

-- Creating Child Table: Orders
-- product_id is the Foreign Key
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
    REFERENCES products(product_id) ON DELETE CASCADE
);


-------  VIEW TABLE DATA---------

-- VIEW all records from Products table

SELECT * FROM products;

-- VIEW all records from Orders table

SELECT * FROM orders;

--Q1. Show each order along with the product name and price.
SELECT 
    orders.order_id,
    products.product_name,
    products.price
FROM orders
INNER JOIN products
ON orders.product_id = products.product_id;

--Q2. Show all products even if they were never ordered.
SELECT
    pr.product_id,
    pr.product_name,
    pr.price,
    ord.order_id
FROM products AS pr
LEFT JOIN orders AS ord
ON pr.product_id = ord.product_id;

--Q3.Show orders for only ‘Electronics’ category.
SELECT
    ord.order_id,
    pr.product_name,
    pr.price,
    pr.category
FROM orders AS ord
INNER JOIN products AS pr
ON ord.product_id = pr.product_id
WHERE pr.category = 'Electronics';

--Q4.List all orders sorted by product price (high to low).
SELECT
    ord.order_id,
    pr.product_name,
    pr.price
FROM orders AS ord
INNER JOIN products AS pr
ON ord.product_id = pr.product_id
ORDER BY pr.price DESC;

--Q5.Show number of orders placed for each product.
SELECT
    pr.product_id,
    pr.product_name,
    COUNT(ord.order_id) AS total_orders
FROM products AS pr
LEFT JOIN orders AS ord
ON pr.product_id = ord.product_id
GROUP BY pr.product_id, pr.product_name;

--Q6.Show total revenue earned per product.
SELECT
    pr.product_id,
    pr.product_name,
    SUM(pr.price) AS total_revenue
FROM products AS pr
INNER JOIN orders AS ord
ON pr.product_id = ord.product_id
GROUP BY pr.product_id, pr.product_name;

--Q7.Show products where total order revenue > ₹2000.
SELECT
    pr.product_id,
    pr.product_name,
    SUM(pr.price) AS total_revenue
FROM products AS pr
INNER JOIN orders AS ord
ON pr.product_id = ord.product_id
GROUP BY pr.product_id, pr.product_name
HAVING SUM(pr.price) > 2000;

--Q8.Show unique customers who ordered ‘Fitness’ products.
SELECT DISTINCT
    o.customer_name,
    p.product_name
FROM orders AS o
INNER JOIN products AS p
ON o.product_id = p.product_id
WHERE p.category = 'Fitness'
ORDER BY o.customer_name;

--project-complete