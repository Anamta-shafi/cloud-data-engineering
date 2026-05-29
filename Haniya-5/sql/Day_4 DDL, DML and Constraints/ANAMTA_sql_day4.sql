-- ================================================================================
-- HOMEWORK: CLASS 4 - MODIFYING DATA, DDL, DATA TYPES & CONSTRAINTS
-- Database: BikeStores Sample Database
-- ================================================================================

-- ================================================================================
-- SECTION A: DATA TYPES & CONSTRAINTS
-- ================================================================================

-- Q1: What data type would you use for a product's weight (e.g., 2.5 kg)?
-- Answer:
-- DECIMAL(5,2)

-- Q2: In the sales.stores table, the zip_code is VARCHAR(5). Why not use INT?
-- Answer:
-- Zip codes are not used in calculations and may contain leading zeros.
-- VARCHAR preserves values like '02115', while INT would store it as 2115.

-- Q3: Look at sales.orders.order_status. The comment says
-- 1=Pending,2=Processing,3=Rejected,4=Completed.
-- Is TINYINT a good choice? Why not use INT?
-- Answer:
-- Yes. TINYINT is a good choice because only small values (1-4) are stored.
-- TINYINT uses 1 byte, while INT uses 4 bytes.

-- Q4: If you add a CHECK constraint that rating must be BETWEEN 1 AND 5,
-- what happens if you try to INSERT rating = 0?
-- Answer:
-- SQL Server rejects the INSERT because it violates the CHECK constraint.

-- Q5: Why does sales.staffs have UNIQUE constraint on email but not on phone?
-- Answer:
-- Email should be unique for each staff member.
-- Phone numbers can be shared, changed, or left NULL.


-- ================================================================================
-- SECTION B: DDL (CREATE, ALTER, DROP)
-- ================================================================================

-- Q6
CREATE TABLE sales.loyalty_programs
(
    program_id INT IDENTITY(1,1) PRIMARY KEY,

    program_name VARCHAR(100)
        NOT NULL UNIQUE,

    discount_rate DECIMAL(3,2)
        NOT NULL
        DEFAULT 0.05
        CHECK (discount_rate BETWEEN 0.00 AND 0.50),

    start_date DATE
        NOT NULL
        DEFAULT GETDATE(),

    end_date DATE NULL
);

-- Q7
ALTER TABLE sales.customers
ADD loyalty_program_id INT NULL;

-- Q8
ALTER TABLE sales.customers
ADD CONSTRAINT FK_Customers_LoyaltyPrograms
FOREIGN KEY (loyalty_program_id)
REFERENCES sales.loyalty_programs(program_id);

-- Q9
ALTER TABLE sales.customers
ALTER COLUMN zip_code VARCHAR(10);

-- Q10
ALTER TABLE sales.customers
ADD birth_date DATE NULL;

ALTER TABLE sales.customers
DROP COLUMN birth_date;

-- Q11
CREATE TABLE production.product_reviews
(
    review_id INT IDENTITY(1,1) PRIMARY KEY,

    product_id INT NOT NULL,

    customer_id INT NOT NULL,

    rating TINYINT
        CHECK (rating BETWEEN 1 AND 5),

    review_text VARCHAR(1000),

    review_date DATE
        DEFAULT GETDATE(),

    CONSTRAINT FK_ProductReviews_Product
        FOREIGN KEY (product_id)
        REFERENCES production.products(product_id),

    CONSTRAINT FK_ProductReviews_Customer
        FOREIGN KEY (customer_id)
        REFERENCES sales.customers(customer_id)
);


-- ================================================================================
-- SECTION C: INSERT STATEMENTS
-- ================================================================================

-- Q12
INSERT INTO production.brands (brand_name)
VALUES ('Santa Cruz');

-- Q13
INSERT INTO production.categories (category_name)
VALUES
('Mountain'),
('Road'),
('Hybrid');

-- Q14
INSERT INTO production.products
(
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price
)
VALUES
(
    'Santa Cruz Bronson',

    (
        SELECT brand_id
        FROM production.brands
        WHERE brand_name = 'Santa Cruz'
    ),

    (
        SELECT category_id
        FROM production.categories
        WHERE category_name = 'Mountain'
    ),

    2025,
    4299.99
);

-- Q15
SELECT *
INTO sales.ca_customers_backup
FROM sales.customers
WHERE 1 = 0;

INSERT INTO sales.ca_customers_backup
SELECT *
FROM sales.customers
WHERE state = 'CA';


-- ================================================================================
-- SECTION D: UPDATE STATEMENTS
-- ================================================================================

-- Q16
UPDATE sales.customers
SET phone = '(555) 123-4567'
WHERE customer_id = 10;

-- Q17
UPDATE p
SET list_price = list_price * 1.08
FROM production.products p
JOIN production.categories c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Road';

-- Q18
UPDATE sales.orders
SET shipped_date = DATEADD(DAY, 3, order_date)
WHERE order_status = 4
AND shipped_date IS NULL;

-- Q19
UPDATE sales.staffs
SET manager_id = 5
WHERE store_id = 1
AND staff_id <> 5;

-- Q20
UPDATE sales.order_items
SET discount = 0.15
WHERE order_id = 100
AND item_id = 2;


-- ================================================================================
-- SECTION E: DELETE STATEMENTS
-- ================================================================================

-- Q21
DELETE FROM production.brands
WHERE brand_name = 'Santa Cruz';

-- Q22
DELETE FROM sales.order_items
WHERE quantity = 0;

-- Q23
DELETE FROM sales.customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM sales.orders o
    WHERE o.customer_id = c.customer_id
);

-- Q24
DELETE FROM production.products
WHERE list_price > 10000
AND model_year < 2020;

-- Q25
DROP TABLE sales.loyalty_programs;


-- ================================================================================
-- SECTION F: COMBINED & CHALLENGE QUESTIONS
-- ================================================================================

-- Q26
BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO sales.stores
    (
        store_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    )
    VALUES
    (
        'Downtown LA',
        '555-0000',
        'downtownla@store.com',
        '100 Main St',
        'Los Angeles',
        'CA',
        '90001'
    );

    DECLARE @StoreID INT = SCOPE_IDENTITY();

    INSERT INTO sales.staffs
    (
        first_name,
        last_name,
        email,
        phone,
        active,
        store_id,
        manager_id
    )
    VALUES
    ('John','Smith','john@store.com','5551111111',1,@StoreID,NULL),
    ('Sara','Jones','sara@store.com','5552222222',1,@StoreID,NULL),
    ('Mike','Brown','mike@store.com','5553333333',1,@StoreID,NULL);

    INSERT INTO production.stocks
    (
        store_id,
        product_id,
        quantity
    )
    VALUES
    (
        @StoreID,
        1,
        100
    );

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH

    ROLLBACK TRANSACTION;

    PRINT ERROR_MESSAGE();

END CATCH;


-- Q27
ALTER TABLE sales.order_items
ADD tax_amount DECIMAL(8,2)
DEFAULT 0.00;

UPDATE sales.order_items
SET tax_amount =
    list_price * quantity * discount * 0.08;


-- Q28
WITH DuplicateEmails AS
(
    SELECT
        customer_id,
        email,
        ROW_NUMBER() OVER
        (
            PARTITION BY email
            ORDER BY customer_id
        ) AS rn
    FROM sales.customers
    WHERE email IS NOT NULL
)
DELETE FROM DuplicateEmails
WHERE rn > 1;


-- Q29
SELECT *
INTO sales.orders_archive
FROM sales.orders
WHERE 1 = 0;

INSERT INTO sales.orders_archive
SELECT *
FROM sales.orders
WHERE YEAR(order_date) <= 2020;

DELETE FROM sales.orders
WHERE YEAR(order_date) <= 2020;


-- Q30
ALTER TABLE production.products
ADD CONSTRAINT CK_Products_Price_Year
CHECK
(
    list_price >= 0
    AND model_year BETWEEN 1900 AND YEAR(GETDATE()) + 1
);

-- ================================================================================
-- END OF HOMEWORK
-- ================================================================================