-- =====================================================
-- Snowflake Setup Worksheet
-- =====================================================
-- This worksheet contains setup commands for a Snowflake environment
-- Run these commands in sequence to set up your database environment

-- =====================================================
-- 1. CREATE WAREHOUSE
-- =====================================================
-- Create a virtual warehouse for compute resources
CREATE OR REPLACE WAREHOUSE DEMO_WH
WITH 
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
COMMENT = 'Demo warehouse for development';

-- Use the warehouse
USE WAREHOUSE DEMO_WH;

-- =====================================================
-- 2. CREATE DATABASE
-- =====================================================
-- Create main database
CREATE OR REPLACE DATABASE DEMO_DB
COMMENT = 'Demo database for development';

-- Use the database
USE DATABASE DEMO_DB;

-- =====================================================
-- 3. CREATE SCHEMAS
-- =====================================================
-- Create schemas for organizing data
CREATE OR REPLACE SCHEMA RAW_DATA
COMMENT = 'Schema for raw, unprocessed data';

CREATE OR REPLACE SCHEMA STAGING
COMMENT = 'Schema for staged and cleaned data';

CREATE OR REPLACE SCHEMA ANALYTICS
COMMENT = 'Schema for analytics and reporting data';

-- Use the raw data schema
USE SCHEMA RAW_DATA;

-- =====================================================
-- 4. CREATE SAMPLE TABLES
-- =====================================================
-- Create a sample customers table
CREATE OR REPLACE TABLE CUSTOMERS (
    CUSTOMER_ID INTEGER AUTOINCREMENT PRIMARY KEY,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(100) UNIQUE,
    PHONE VARCHAR(20),
    CREATED_DATE TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    UPDATED_DATE TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Create a sample orders table
CREATE OR REPLACE TABLE ORDERS (
    ORDER_ID INTEGER AUTOINCREMENT PRIMARY KEY,
    CUSTOMER_ID INTEGER,
    ORDER_DATE DATE,
    TOTAL_AMOUNT DECIMAL(10,2),
    STATUS VARCHAR(20) DEFAULT 'PENDING',
    CREATED_DATE TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID)
);

-- Create a sample products table
CREATE OR REPLACE TABLE PRODUCTS (
    PRODUCT_ID INTEGER AUTOINCREMENT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(100) NOT NULL,
    CATEGORY VARCHAR(50),
    PRICE DECIMAL(10,2),
    DESCRIPTION TEXT,
    CREATED_DATE TIMESTAMP_LTZ DEFAULT CURRENT_TIMESTAMP()
);

-- =====================================================
-- 5. INSERT SAMPLE DATA
-- =====================================================
-- Insert sample customers
INSERT INTO CUSTOMERS (FIRST_NAME, LAST_NAME, EMAIL, PHONE) VALUES
    ('John', 'Doe', 'john.doe@email.com', '555-0101'),
    ('Jane', 'Smith', 'jane.smith@email.com', '555-0102'),
    ('Bob', 'Johnson', 'bob.johnson@email.com', '555-0103'),
    ('Alice', 'Williams', 'alice.williams@email.com', '555-0104'),
    ('Charlie', 'Brown', 'charlie.brown@email.com', '555-0105');

-- Insert sample products
INSERT INTO PRODUCTS (PRODUCT_NAME, CATEGORY, PRICE, DESCRIPTION) VALUES
    ('Laptop Pro', 'Electronics', 1299.99, 'High-performance laptop for professionals'),
    ('Wireless Headphones', 'Electronics', 199.99, 'Premium noise-canceling headphones'),
    ('Office Chair', 'Furniture', 299.99, 'Ergonomic office chair with lumbar support'),
    ('Coffee Mug', 'Kitchen', 19.99, 'Ceramic coffee mug with company logo'),
    ('Notebook Set', 'Office Supplies', 24.99, 'Set of 3 premium notebooks');

-- Insert sample orders
INSERT INTO ORDERS (CUSTOMER_ID, ORDER_DATE, TOTAL_AMOUNT, STATUS) VALUES
    (1, '2024-01-15', 1299.99, 'COMPLETED'),
    (2, '2024-01-16', 199.99, 'COMPLETED'),
    (3, '2024-01-17', 319.98, 'PENDING'),
    (4, '2024-01-18', 44.98, 'SHIPPED'),
    (5, '2024-01-19', 1519.98, 'PROCESSING');

-- =====================================================
-- 6. CREATE VIEWS
-- =====================================================
-- Create a view for customer order summary
CREATE OR REPLACE VIEW ANALYTICS.CUSTOMER_ORDER_SUMMARY AS
SELECT 
    c.CUSTOMER_ID,
    c.FIRST_NAME,
    c.LAST_NAME,
    c.EMAIL,
    COUNT(o.ORDER_ID) as TOTAL_ORDERS,
    SUM(o.TOTAL_AMOUNT) as TOTAL_SPENT,
    AVG(o.TOTAL_AMOUNT) as AVG_ORDER_VALUE,
    MAX(o.ORDER_DATE) as LAST_ORDER_DATE
FROM RAW_DATA.CUSTOMERS c
LEFT JOIN RAW_DATA.ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
GROUP BY c.CUSTOMER_ID, c.FIRST_NAME, c.LAST_NAME, c.EMAIL;

-- =====================================================
-- 7. VERIFICATION QUERIES
-- =====================================================
-- Check the created objects
SHOW WAREHOUSES;
SHOW DATABASES;
SHOW SCHEMAS;
SHOW TABLES;
SHOW VIEWS;

-- Sample data verification
SELECT 'CUSTOMERS' as TABLE_NAME, COUNT(*) as ROW_COUNT FROM RAW_DATA.CUSTOMERS
UNION ALL
SELECT 'ORDERS', COUNT(*) FROM RAW_DATA.ORDERS
UNION ALL
SELECT 'PRODUCTS', COUNT(*) FROM RAW_DATA.PRODUCTS;

-- Test the view
SELECT * FROM ANALYTICS.CUSTOMER_ORDER_SUMMARY;

-- =====================================================
-- 8. CLEANUP (OPTIONAL)
-- =====================================================
-- Uncomment the following lines if you need to clean up
/*
DROP VIEW IF EXISTS ANALYTICS.CUSTOMER_ORDER_SUMMARY;
DROP TABLE IF EXISTS RAW_DATA.ORDERS;
DROP TABLE IF EXISTS RAW_DATA.CUSTOMERS;
DROP TABLE IF EXISTS RAW_DATA.PRODUCTS;
DROP SCHEMA IF EXISTS ANALYTICS;
DROP SCHEMA IF EXISTS STAGING;
DROP SCHEMA IF EXISTS RAW_DATA;
DROP DATABASE IF EXISTS DEMO_DB;
DROP WAREHOUSE IF EXISTS DEMO_WH;
*/

-- =====================================================
-- END OF SETUP WORKSHEET
-- ===================================================== 