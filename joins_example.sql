-- Таблица customers
CREATE TABLE customers (
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    city VARCHAR(50),
    region VARCHAR(20)
);

-- Таблица orders
CREATE TABLE orders (
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    sales DECIMAL(10,2),
    category VARCHAR(50),
    order_date DATE
);

SELECT
    c.customer_name,
    c.segment,
    o.order_id,
    o.sales,
    o.category
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
ORDER BY o.sales DESC;

SELECT
    c.customer_name,
    c.region,
    o.order_id,
    o.sales
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT
    c.segment,
    COUNT(o.order_id) AS total_orders,
    SUM(o.sales) AS total_sales,
    AVG(o.sales) AS avg_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.segment
ORDER BY total_sales DESC;
