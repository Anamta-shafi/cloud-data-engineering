-- ============================================================
-- RETAILMART CAPSTONE PROJECT - COMPLETE SUBMISSION FILE
-- Includes Tasks 1 to 14
-- ============================================================

CREATE SCHEMA retailmart;
GO

-- =========================
-- TASK 1: DDL
-- =========================

CREATE TABLE retailmart.categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(200) NOT NULL
);

CREATE TABLE retailmart.products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(300) NOT NULL,
    category_id INT NOT NULL REFERENCES retailmart.categories(category_id),
    price DECIMAL(10,2) NOT NULL CHECK(price > 0),
    stock_qty INT NOT NULL DEFAULT 0
);

CREATE TABLE retailmart.stores (
    store_id INT PRIMARY KEY IDENTITY(1,1),
    store_name VARCHAR(300) NOT NULL,
    city VARCHAR(300) NOT NULL
);

CREATE TABLE retailmart.customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    full_name VARCHAR(300) NOT NULL,
    email VARCHAR(300) NOT NULL UNIQUE,
    city VARCHAR(300),
    gender CHAR(1) CHECK(gender IN ('M','F'))
);

CREATE TABLE retailmart.orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    store_id INT NOT NULL REFERENCES retailmart.stores(store_id),
    customer_id INT NOT NULL REFERENCES retailmart.customers(customer_id),
    order_date DATE NOT NULL DEFAULT GETDATE(),
    status VARCHAR(200) NOT NULL DEFAULT 'Pending'
        CHECK(status IN ('Pending','Shipped','Delivered','Cancelled'))
);

CREATE TABLE retailmart.order_items (
    item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL REFERENCES retailmart.orders(order_id),
    product_id INT NOT NULL REFERENCES retailmart.products(product_id),
    quantity INT NOT NULL CHECK(quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL
);

-- =========================
-- TASK 2: DML
-- =========================

INSERT INTO retailmart.categories (category_name) VALUES
('Electronics'),('Clothing'),('Groceries'),
('Accessories'),('Home Appliances');

INSERT INTO retailmart.products (product_name,category_id,price,stock_qty) VALUES
('Samsung 4K TV',1,85000,15),
('iPhone 15',1,295000,10),
('Wireless Earbuds',4,4500,80),
('Leather Jacket',2,8500,40),
('Linen Shirt',2,2200,60),
('Rice 5kg',3,950,200),
('Cooking Oil 3L',3,750,150),
('Sunglasses',4,1800,55),
('Microwave Oven',5,18000,20),
('Electric Kettle',5,3200,35);

INSERT INTO retailmart.stores (store_name,city) VALUES
('RetailMart Karachi','Karachi'),
('RetailMart Lahore','Lahore'),
('RetailMart Islamabad','Islamabad');

INSERT INTO retailmart.customers (full_name,email,city,gender) VALUES
('Ahmed Khan','ahmed@gmail.com','Karachi','M'),
('Sara Malik','sara@gmail.com','Lahore','F'),
('Bilal Hussain','bilal@gmail.com','Islamabad','M'),
('Fatima Nawaz','fatima@gmail.com','Karachi','F'),
('Omar Sheikh','omar@gmail.com','Lahore','M'),
('Nadia Ali','nadia@gmail.com','Islamabad','F'),
('Hamza Raza','hamza@gmail.com','Karachi','M'),
('Zara Qureshi','zara@gmail.com','Lahore','F');

INSERT INTO retailmart.orders (store_id,customer_id,order_date,status) VALUES
(1,1,'2024-01-10','Delivered'),
(1,4,'2024-01-15','Delivered'),
(2,2,'2024-02-03','Delivered'),
(2,5,'2024-02-20','Shipped'),
(3,3,'2024-03-05','Delivered'),
(3,6,'2024-03-18','Pending'),
(1,7,'2024-04-01','Delivered'),
(2,8,'2024-04-22','Cancelled'),
(1,1,'2024-05-10','Delivered'),
(3,3,'2024-06-01','Shipped');

INSERT INTO retailmart.order_items (order_id,product_id,quantity,unit_price) VALUES
(1,2,1,295000),(1,3,2,4500),(2,4,1,8500),
(3,5,3,2200),(3,8,1,1800),(4,1,1,85000),
(5,9,1,18000),(5,10,2,3200),(6,6,4,950),
(7,3,1,4500),(8,2,1,295000),(9,4,2,8500),
(10,9,1,18000);

UPDATE retailmart.products
SET price = price * 0.90
WHERE product_id = 10;

DELETE FROM retailmart.order_items WHERE order_id = 8;
DELETE FROM retailmart.orders WHERE order_id = 8;

-- =========================
-- TASK 3
-- =========================

SELECT * FROM retailmart.products WHERE price < 5000;
SELECT * FROM retailmart.customers WHERE city='Karachi';
SELECT * FROM retailmart.orders
WHERE YEAR(order_date)=2024
ORDER BY order_date DESC;

-- =========================
-- TASK 4
-- =========================

SELECT o.order_id,c.full_name,p.product_name,oi.quantity,oi.unit_price
FROM retailmart.orders o
JOIN retailmart.customers c ON o.customer_id=c.customer_id
JOIN retailmart.order_items oi ON o.order_id=oi.order_id
JOIN retailmart.products p ON oi.product_id=p.product_id;

SELECT c.customer_id,c.full_name,o.order_id
FROM retailmart.customers c
LEFT JOIN retailmart.orders o
ON c.customer_id=o.customer_id;

SELECT p.product_name,oi.order_id
FROM retailmart.order_items oi
RIGHT JOIN retailmart.products p
ON oi.product_id=p.product_id;

-- =========================
-- TASK 5
-- =========================

SELECT s.store_name,c.category_name,
SUM(oi.quantity*oi.unit_price) AS Revenue
FROM retailmart.order_items oi
JOIN retailmart.orders o ON oi.order_id=o.order_id
JOIN retailmart.products p ON oi.product_id=p.product_id
JOIN retailmart.categories c ON p.category_id=c.category_id
JOIN retailmart.stores s ON o.store_id=s.store_id
GROUP BY s.store_name,c.category_name;

SELECT product_name,price,
CASE
WHEN price<5000 THEN 'Budget'
WHEN price BETWEEN 5000 AND 50000 THEN 'Mid-Range'
ELSE 'Premium'
END AS ProductType
FROM retailmart.products;

-- TASK 7

SELECT order_id
FROM retailmart.order_items
GROUP BY order_id
HAVING SUM(quantity*unit_price) >
(
SELECT AVG(OrderTotal)
FROM (
SELECT SUM(quantity*unit_price) AS OrderTotal
FROM retailmart.order_items
GROUP BY order_id
)A
);

-- TASK 8

SELECT city FROM retailmart.customers
UNION
SELECT city FROM retailmart.stores;

SELECT customer_id FROM retailmart.orders WHERE store_id=1
INTERSECT
SELECT customer_id FROM retailmart.orders WHERE store_id=2;

SELECT customer_id FROM retailmart.customers
EXCEPT
SELECT customer_id FROM retailmart.orders;

-- TASK 9

WITH CustomerSpend AS (
SELECT c.customer_id,c.full_name,
SUM(oi.quantity*unit_price) AS TotalSpend
FROM retailmart.customers c
JOIN retailmart.orders o ON c.customer_id=o.customer_id
JOIN retailmart.order_items oi ON o.order_id=oi.order_id
GROUP BY c.customer_id,c.full_name
)
SELECT TOP 5 *
FROM CustomerSpend
ORDER BY TotalSpend DESC;

-- TASK 10

SELECT p.product_name,
SUM(oi.quantity*oi.unit_price) AS Revenue,
ROW_NUMBER() OVER(ORDER BY SUM(oi.quantity*oi.unit_price) DESC) AS RowNum,
RANK() OVER(ORDER BY SUM(oi.quantity*oi.unit_price) DESC) AS ProductRank
FROM retailmart.products p
JOIN retailmart.order_items oi ON p.product_id=oi.product_id
GROUP BY p.product_name;

-- TASK 12

CREATE VIEW retailmart.vw_OrderSummary AS
SELECT o.order_id,c.full_name,s.store_name,o.order_date,o.status
FROM retailmart.orders o
JOIN retailmart.customers c ON o.customer_id=c.customer_id
JOIN retailmart.stores s ON o.store_id=s.store_id;

-- TASK 13

CREATE NONCLUSTERED INDEX IX_Orders_Customer_Date
ON retailmart.orders(customer_id,order_date);

CREATE NONCLUSTERED INDEX IX_PendingOrders
ON retailmart.orders(status)
WHERE status='Pending';

CREATE NONCLUSTERED INDEX IX_CustomerEmail
ON retailmart.customers(email);

-- TASK 14

CREATE PROCEDURE retailmart.sp_MonthlySalesReport
@StoreID INT,
@Year INT = YEAR(GETDATE())
AS
BEGIN
SELECT MONTH(o.order_date) AS MonthNo,
SUM(oi.quantity*oi.unit_price) AS TotalSales
FROM retailmart.orders o
JOIN retailmart.order_items oi ON o.order_id=oi.order_id
WHERE o.store_id=@StoreID
AND YEAR(o.order_date)=@Year
GROUP BY MONTH(o.order_date)
ORDER BY MonthNo;
END;
GO
