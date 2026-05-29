-- ============================================================
--  PART A: INDEXES
-- ============================================================

-- Q1.
-- Create a non-clustered index on last_name

CREATE NONCLUSTERED INDEX IX_Customers_LastName
ON sales.customers(last_name);

-- Query that benefits from the index

SELECT *
FROM sales.customers
WHERE last_name = 'Smith';



-- Q2.
-- Create a composite index on customer_id and order_date

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID_OrderDate
ON sales.orders(customer_id, order_date);

-- Query that benefits from the index

SELECT *
FROM sales.orders
WHERE customer_id = 10
AND order_date = '2025-05-01';



-- Q3.
/*
A unique index on phone_number can fail if duplicate phone
numbers already exist in the table.

It may also be problematic if customers are allowed to have
NULL phone numbers.

This is safe only if every customer has a unique phone number
(or if the business rule guarantees uniqueness).
*/



-- Q4.
/*
order_id (Primary Key)
-> SHOULD have an index.
Reason: Primary keys are frequently searched and uniquely
identify rows. SQL Server automatically creates an index.

status (Pending, Shipped, Delivered)
-> SHOULD NOT normally have an index.
Reason: Very low selectivity (only 3 possible values),
so the index is usually not useful.

customer_id (Foreign Key)
-> SHOULD have an index.
Reason: Frequently used in joins and searches for customer orders.

notes (free text, rarely searched)
-> SHOULD NOT have a regular index.
Reason: Large text data and rarely used in search conditions.
A Full-Text Index would be better if text searching is needed.
*/



-- Q5.
-- Check existing indexes

EXEC sp_helpindex 'production.products';

-- Explanation:
/*
index_name      -> Name of the index
index_description -> Type of index (clustered, nonclustered, unique)
index_keys      -> Columns included in the index key
*/



-- ============================================================
--  PART B: STORED PROCEDURES
-- ============================================================

-- Q6.
-- Create stored procedure

CREATE PROCEDURE sp_GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT
        order_id,
        order_date,
        order_status
    FROM sales.orders
    WHERE customer_id = @CustomerID;
END;
GO

-- Test

EXEC sp_GetCustomerOrders 10;



-- Q7.
-- Modified procedure with message when no orders exist

ALTER PROCEDURE sp_GetCustomerOrders
    @CustomerID INT
AS
BEGIN

    IF EXISTS
    (
        SELECT 1
        FROM sales.orders
        WHERE customer_id = @CustomerID
    )
    BEGIN
        SELECT
            order_id,
            order_date,
            order_status
        FROM sales.orders
        WHERE customer_id = @CustomerID;
    END

    ELSE
    BEGIN
        PRINT 'No orders found for this customer';
    END

END;
GO



-- Q8.
-- Products by category with default price

CREATE PROCEDURE sp_ProductsByCategory
    @CategoryID INT,
    @MaxPrice DECIMAL(10,2) = 9999
AS
BEGIN

    SELECT *
    FROM production.products
    WHERE category_id = @CategoryID
      AND list_price <= @MaxPrice
    ORDER BY list_price ASC;

END;
GO

-- Examples

EXEC sp_ProductsByCategory 2;

EXEC sp_ProductsByCategory
     @CategoryID = 2,
     @MaxPrice = 500;



-- ============================================================
--  PART C: MIXED / THINK QUESTIONS
-- ============================================================

-- Q9.
/*
1. Create an index on (store_id, order_date).
   Reason: The procedure filters using these columns, so the
   database can locate rows much faster.

2. Review and optimize the stored procedure logic.
   Reason: Avoid SELECT *, unnecessary calculations,
   functions on indexed columns, and return only required data.
*/



-- Q10.
/*
Creating indexes on every column is a bad idea because each
index consumes storage space and memory. Whenever an INSERT,
UPDATE, or DELETE occurs, SQL Server must also update all
related indexes, which slows down write operations.
Too many indexes can even confuse the query optimizer and
increase maintenance costs. Indexes should only be created
on columns that are frequently searched, joined, sorted,
or filtered.
*/

-- ============================================================
--  END OF HOMEWORK
-- ============================================================