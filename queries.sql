-- Тут не пришлось использовать Join :( по этому добавлю несколько примеров в другом файле

-- =============================================
-- SUPERSTORE SQL ANALYSIS
-- =============================================
-- 1. Общая выручка по всем заказам
SELECT SUM(Sales) AS total_revenue
FROM superstore;

-- 2. Количество заказов по каждому региону
SELECT Region, COUNT(*) AS total_orders
FROM superstore
GROUP BY Region
ORDER BY total_orders DESC;

-- 3. Средний чек по каждому сегменту клиентов
SELECT Segment, ROUND(AVG(Sales), 2) AS avg_order
FROM superstore
GROUP BY Segment
ORDER BY avg_order DESC;

-- 4. Топ-5 городов по выручке
SELECT City, SUM(Sales) AS total_sales
FROM superstore
GROUP BY City
ORDER BY total_sales DESC
LIMIT 5;

-- 5. Количество уникальных клиентов
SELECT COUNT(DISTINCT "Customer ID") AS unique_customers
FROM superstore;

-- 6. Выручка по категориям только в регионе West
SELECT Category, SUM(Sales) AS total_sales
FROM superstore
WHERE Region = 'West'
GROUP BY Category
ORDER BY total_sales DESC;

-- 7. Категории где средний чек выше 200
SELECT Category, ROUND(AVG(Sales), 2) AS avg_sales
FROM superstore
GROUP BY Category
HAVING AVG(Sales) > 200
ORDER BY avg_sales DESC;

-- 8. Топ-10 самых дорогих заказов
SELECT "Order ID", "Customer Name", Sales, Region, Category
FROM superstore
ORDER BY Sales DESC
LIMIT 10;

-- 9. Заказы выше средней выручки
SELECT "Order ID", "Customer Name", Sales
FROM superstore
WHERE Sales > (SELECT AVG(Sales) FROM superstore)
ORDER BY Sales DESC;

-- 10. CTE — регионы выше средней выручки по всем регионам
WITH region_sales AS (
    SELECT Region, SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY Region
),
avg_sales AS (
    SELECT AVG(total_sales) AS avg_region_sales
    FROM region_sales
)
SELECT r.Region, r.total_sales
FROM region_sales r, avg_sales a
WHERE r.total_sales > a.avg_region_sales
ORDER BY r.total_sales DESC;

-- 11. Ранг регионов по выручке
SELECT
    Region,
    SUM(Sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS rank
FROM superstore
GROUP BY Region;

-- 12. Место каждой Sub-Category внутри своей Category
WITH sub_sales AS (
    SELECT
        Category,
        "Sub-Category",
        SUM(Sales) AS total_sales
    FROM superstore
    GROUP BY Category, "Sub-Category"
)
SELECT
    Category,
    "Sub-Category",
    total_sales,
    RANK() OVER (PARTITION BY Category ORDER BY total_sales DESC) AS rank_in_category
FROM sub_sales;

-- 13. CASE WHEN — классификация заказов по размеру
SELECT
    "Order ID",
    Sales,
    CASE
        WHEN Sales >= 1000 THEN 'Крупный'
        WHEN Sales >= 500  THEN 'Средний'
        WHEN Sales >= 100  THEN 'Маленький'
        ELSE 'Микро'
    END AS order_size
FROM superstore
ORDER BY Sales DESC;
