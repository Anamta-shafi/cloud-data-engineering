-- ================================================================================
-- HOMEWORK: CLASS 5 - CTEs, PIVOT, EXPRESSIONS & WINDOW FUNCTIONS
-- Database: BikeStores Sample Database
-- ================================================================================

-- ================================================================================
-- SECTION A: CASE Expressions
-- ================================================================================

-- Q1
SELECT
    order_id,
    order_status,
    CASE order_status
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Processing'
        WHEN 3 THEN 'Rejected'
        WHEN 4 THEN 'Completed'
    END AS status_description
FROM sales.orders;


-- Q2
SELECT
    product_name,
    list_price,
    CASE
        WHEN list_price < 500 THEN 'Budget'
        WHEN list_price BETWEEN 500 AND 2000 THEN 'Standard'
        ELSE 'Premium'
    END AS price_category
FROM production.products;


-- Q3
SELECT
    store_id,
    COUNT(CASE WHEN order_status = 4 THEN 1 END) AS completed_count,
    COUNT(CASE WHEN order_status <> 4 THEN 1 END) AS not_completed_count
FROM sales.orders
GROUP BY store_id;


-- Q4
SELECT
    product_name,
    model_year,
    CASE
        WHEN model_year = 2024 THEN 'New'
        WHEN model_year = 2023 THEN 'Recent'
        ELSE 'Older'
    END AS year_label
FROM production.products;


-- Q5
SELECT
    email,
    CASE
        WHEN email IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS has_email
FROM sales.customers;


-- ================================================================================
-- SECTION B: CTEs
-- ================================================================================

-- Q6
WITH high_value_products AS
(
    SELECT *
    FROM production.products
    WHERE list_price > 3000
)
SELECT *
FROM high_value_products;


-- Q7
WITH avg_price_cte AS
(
    SELECT AVG(list_price) AS avg_price
    FROM production.products
)
SELECT
    p.product_name,
    p.list_price
FROM production.products p
CROSS JOIN avg_price_cte a
WHERE p.list_price > a.avg_price;


-- Q8
WITH customer_order_counts AS
(
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM sales.orders
    GROUP BY customer_id
)
SELECT *
FROM customer_order_counts
WHERE order_count > 5;


-- ================================================================================
-- SECTION C: ROW_NUMBER() and RANK()
-- ================================================================================

-- Q9
SELECT
    product_name,
    list_price,
    ROW_NUMBER() OVER(ORDER BY list_price DESC) AS row_number
FROM production.products;


-- Q10
SELECT
    brand_id,
    product_name,
    list_price,
    ROW_NUMBER() OVER
    (
        PARTITION BY brand_id
        ORDER BY list_price DESC
    ) AS rank_in_brand
FROM production.products;


-- Q11
SELECT
    product_name,
    list_price,
    RANK() OVER(ORDER BY list_price DESC) AS product_rank
FROM production.products;


-- ================================================================================
-- SECTION D: Window Functions
-- ================================================================================

-- Q12
WITH daily_orders AS
(
    SELECT
        order_date,
        COUNT(*) AS daily_order_count
    FROM sales.orders
    GROUP BY order_date
)
SELECT
    order_date,
    daily_order_count,
    SUM(daily_order_count) OVER
    (
        ORDER BY order_date
    ) AS running_total
FROM daily_orders;


-- Q13
SELECT
    product_name,
    list_price,
    AVG(list_price) OVER
    (
        PARTITION BY brand_id
    ) AS avg_brand_price
FROM production.products;


-- Q14
SELECT
    oi.product_id,
    o.order_date,
    oi.quantity,
    SUM(oi.quantity) OVER
    (
        PARTITION BY oi.product_id
        ORDER BY o.order_date
    ) AS cumulative_quantity
FROM sales.order_items oi
JOIN sales.orders o
    ON oi.order_id = o.order_id;


-- ================================================================================
-- SECTION E: LAG & LEAD
-- ================================================================================

-- Q15
SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER
    (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date
FROM sales.orders;


-- Q16
SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER
    (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_order_date,

    DATEDIFF
    (
        DAY,
        LAG(order_date) OVER
        (
            PARTITION BY customer_id
            ORDER BY order_date
        ),
        order_date
    ) AS days_between_orders
FROM sales.orders;


-- ================================================================================
-- SECTION F: PIVOT
-- ================================================================================

-- Q17
SELECT
    store_id,
    ISNULL([1],0) AS Pending,
    ISNULL([2],0) AS Processing,
    ISNULL([3],0) AS Rejected,
    ISNULL([4],0) AS Completed
FROM
(
    SELECT
        store_id,
        order_status
    FROM sales.orders
) src
PIVOT
(
    COUNT(order_status)
    FOR order_status IN ([1],[2],[3],[4])
) p;


-- ================================================================================
-- SECTION G: Mixed Practice
-- ================================================================================

-- Q18
WITH customer_spending AS
(
    SELECT
        c.customer_id,
        CONCAT(c.first_name,' ',c.last_name) AS customer_name,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_spending
    FROM sales.customers c
    JOIN sales.orders o
        ON c.customer_id = o.customer_id
    JOIN sales.order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    customer_name,
    CASE
        WHEN total_spending > 5000 THEN 'VIP'
        WHEN total_spending BETWEEN 1000 AND 5000 THEN 'Regular'
        ELSE 'New'
    END AS tier
FROM customer_spending;


-- Q19
WITH ranked_products AS
(
    SELECT
        category_id,
        product_name,
        list_price,
        ROW_NUMBER() OVER
        (
            PARTITION BY category_id
            ORDER BY list_price DESC
        ) AS rn
    FROM production.products
)
SELECT
    category_id,
    product_name,
    list_price,
    CASE rn
        WHEN 1 THEN 'Gold'
        WHEN 2 THEN 'Silver'
        WHEN 3 THEN 'Bronze'
    END AS medal
FROM ranked_products
WHERE rn <= 3;


-- Q20
WITH monthly_revenue AS
(
    SELECT
        YEAR(o.order_date) AS order_year,
        MONTH(o.order_date) AS order_month,

        SUM
        (
            oi.quantity *
            oi.list_price *
            (1 - oi.discount)
        ) AS revenue
    FROM sales.orders o
    JOIN sales.order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
)
SELECT
    order_year,
    order_month,
    revenue,

    LAG(revenue) OVER
    (
        ORDER BY order_year, order_month
    ) AS previous_month_revenue,

    revenue -
    LAG(revenue) OVER
    (
        ORDER BY order_year, order_month
    ) AS revenue_growth
FROM monthly_revenue;


-- Q21
WITH ranked_products AS
(
    SELECT
        product_name,
        brand_id,
        list_price,

        ROW_NUMBER() OVER
        (
            PARTITION BY brand_id
            ORDER BY list_price DESC
        ) AS rank_in_brand
    FROM production.products
)
SELECT
    product_name,
    list_price,
    rank_in_brand,

    CASE
        WHEN rank_in_brand = 1 THEN 'Top Product'
        ELSE 'Other'
    END AS product_status
FROM ranked_products;


-- Q22
WITH customer_tiers AS
(
    SELECT
        c.state,

        CASE
            WHEN ISNULL(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),0) > 5000
                THEN 'VIP'
            WHEN ISNULL(SUM(oi.quantity * oi.list_price * (1 - oi.discount)),0) BETWEEN 1000 AND 5000
                THEN 'Regular'
            ELSE 'New'
        END AS tier
    FROM sales.customers c
    LEFT JOIN sales.orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN sales.order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.state
)
SELECT
    state,
    ISNULL([VIP],0) AS VIP,
    ISNULL([Regular],0) AS Regular,
    ISNULL([New],0) AS New
FROM customer_tiers
PIVOT
(
    COUNT(tier)
    FOR tier IN ([VIP],[Regular],[New])
) p;

-- ================================================================================
-- END OF HOMEWORK
-- ================================================================================