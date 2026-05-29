-- ============================================
-- Q1: Count how many products each brand has
-- ============================================
SELECT
    b.brand_name,
    COUNT(p.product_id) AS product_count
FROM production.brands b
JOIN production.products p
    ON b.brand_id = p.brand_id
GROUP BY b.brand_name
ORDER BY product_count DESC;


-- ============================================
-- Q2: Category statistics
-- ============================================
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products,
    MIN(p.list_price) AS cheapest_price,
    MAX(p.list_price) AS most_expensive_price,
    ROUND(AVG(p.list_price), 2) AS average_price
FROM production.categories c
JOIN production.products p
    ON c.category_id = p.category_id
GROUP BY c.category_name
ORDER BY average_price DESC;


-- ============================================
-- Q3: Number of orders per status
-- ============================================
SELECT
    order_status,
    COUNT(order_id) AS order_count
FROM sales.orders
GROUP BY order_status
ORDER BY order_status ASC;


-- ============================================
-- Q4: Total revenue per store
-- ============================================
SELECT
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.stores s
JOIN sales.orders o
    ON s.store_id = o.store_id
JOIN sales.order_items oi
    ON o.order_id = oi.order_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;


-- ============================================
-- Q5: Products per brand per model year
-- ============================================
SELECT
    b.brand_name,
    p.model_year,
    COUNT(*) AS product_count
FROM production.brands b
JOIN production.products p
    ON b.brand_id = p.brand_id
GROUP BY
    b.brand_name,
    p.model_year
ORDER BY
    b.brand_name,
    p.model_year;


-- ============================================
-- Q6: Brands with more than 25 products
-- ============================================
SELECT
    b.brand_name,
    COUNT(*) AS product_count
FROM production.brands b
JOIN production.products p
    ON b.brand_id = p.brand_id
GROUP BY b.brand_name
HAVING COUNT(*) > 25;


-- ============================================
-- Q7: Categories (2018 products only)
-- Average price above $1500
-- ============================================
SELECT
    c.category_name,
    COUNT(*) AS product_count,
    ROUND(AVG(p.list_price), 2) AS average_price
FROM production.categories c
JOIN production.products p
    ON c.category_id = p.category_id
WHERE p.model_year = 2018
GROUP BY c.category_name
HAVING AVG(p.list_price) > 1500
ORDER BY average_price DESC;


-- ============================================
-- Q8: Customers with 3 or more orders
-- ============================================
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS order_count
FROM sales.customers c
JOIN sales.orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.first_name,
    c.last_name
HAVING COUNT(o.order_id) >= 3
ORDER BY order_count DESC;


-- ============================================
-- Q9: Products priced above overall average
-- ============================================
SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price >
(
    SELECT AVG(list_price)
    FROM production.products
)
ORDER BY list_price DESC;


-- ============================================
-- Q10: Orders by customers from TX
-- Use subquery only
-- ============================================
SELECT
    order_id,
    customer_id,
    order_date
FROM sales.orders
WHERE customer_id IN
(
    SELECT customer_id
    FROM sales.customers
    WHERE state = 'TX'
);


-- ============================================
-- Q11: Brand average price greater than
-- overall average price
-- Use derived table (subquery in FROM)
-- ============================================
SELECT
    brand_name,
    avg_price
FROM
(
    SELECT
        b.brand_name,
        AVG(p.list_price) AS avg_price
    FROM production.brands b
    JOIN production.products p
        ON b.brand_id = p.brand_id
    GROUP BY b.brand_name
) AS brand_avg
WHERE avg_price >
(
    SELECT AVG(list_price)
    FROM production.products
);


-- ============================================
-- Q12: Customers who placed at least one order
-- Using EXISTS
-- ============================================
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email
FROM sales.customers c
WHERE EXISTS
(
    SELECT 1
    FROM sales.orders o
    WHERE o.customer_id = c.customer_id
);


-- ============================================
-- Q13: Products never ordered
-- Using NOT EXISTS
-- ============================================
SELECT
    p.product_name,
    p.list_price
FROM production.products p
WHERE NOT EXISTS
(
    SELECT 1
    FROM sales.order_items oi
    WHERE oi.product_id = p.product_id
);