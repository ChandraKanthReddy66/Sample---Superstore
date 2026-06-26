CREATE DATABASE retail_sales;
use retail_sales;

RENAME TABLE `sample - superstore` TO sample_superstore;

ALTER TABLE sample_superstore
RENAME COLUMN `Order Date` TO Order_Date;

ALTER TABLE sample_superstore
RENAME COLUMN `Order ID` TO Order_ID;

ALTER TABLE sample_superstore
RENAME COLUMN `Ship Date` TO Ship_Date;

ALTER TABLE sample_superstore
RENAME COLUMN `Row ID` TO Row_ID;

ALTER TABLE sample_superstore
RENAME COLUMN `Ship mode` TO Ship_mode;

ALTER TABLE sample_superstore
RENAME COLUMN `Customer ID` TO Customer_ID;

ALTER TABLE sample_superstore
RENAME COLUMN `Postal Code` TO Postal_Code;

ALTER TABLE sample_superstore
RENAME COLUMN `Product ID` TO Product_ID;

ALTER TABLE sample_superstore
RENAME COLUMN `Sub-Category` TO Sub_Category;

ALTER TABLE sample_superstore
RENAME COLUMN `Product Name` TO Product_Name;

ALTER TABLE sample_superstore
RENAME COLUMN `sCustomer_Name` TO Customer_Name;


-- Check the table
DESCRIBE sample_superstore;

-- Change Incorrect Data Types

ALTER TABLE sample_superstore
MODIFY COLUMN Customer_Name VARCHAR(100);

ALTER TABLE sample_superstore
MODIFY COLUMN City VARCHAR(50);

ALTER TABLE sample_superstore
MODIFY COLUMN Region VARCHAR(20);

ALTER TABLE sample_superstore
MODIFY COLUMN Category VARCHAR(50);

ALTER TABLE sample_superstore
MODIFY COLUMN Sub_Category VARCHAR(50);

ALTER TABLE sample_superstore
MODIFY COLUMN Sales DECIMAL(10,2);

-- Convert Date Columns

SELECT Order_Date
FROM sample_superstore
LIMIT 10;

ALTER TABLE sample_superstore
modify column Order_Date DATE;

UPDATE sample_superstore
SET Order_Date = STR_TO_DATE(Order_Date, '%m/%d/%Y');

ALTER TABLE sample_superstore
ADD COLUMN Ship_Date DATE;

UPDATE sample_superstore
SET Ship_Date = STR_TO_DATE(`Ship_Date`, '%m/%d/%Y');

-- Total Sales
SELECT ROUND(SUM(Sales),2) AS Total_Sales
FROM sample_superstore;

-- Total Profit
SELECT ROUND(SUM(Profit),2) AS Total_Profit
FROM sample_superstore;
-- Total Orders
SELECT COUNT(DISTINCT Order_id) AS Total_Orders
FROM sample_superstore;

-- Total Customers
SELECT COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM sample_superstore;

-- Average Order Value
SELECT ROUND(SUM(Sales)/COUNT(DISTINCT Order_ID),2)
AS Avg_Order_Value
FROM sample_superstore;

-- Sales by Category
SELECT Category,
       ROUND(SUM(Sales),2) AS Sales
FROM sample_superstore
GROUP BY Category
ORDER BY Sales DESC;

-- Profit by Category
SELECT Category,
       ROUND(SUM(Profit),2) AS Profit
FROM sample_superstore
GROUP BY Category
ORDER BY Profit DESC;

-- Top 10 Products by Sales
SELECT Product_Name,
       ROUND(SUM(Sales),2) AS Sales
FROM sample_superstore
GROUP BY Product_Name
ORDER BY Sales DESC
LIMIT 10;

-- Top 10 Products by Profit
SELECT Product_Name,
       ROUND(SUM(Profit),2) AS Profit
FROM sample_superstore
GROUP BY Product_Name
ORDER BY Profit DESC
LIMIT 10;

-- Bottom 10 Products by Profit
SELECT Product_Name,
       ROUND(SUM(Profit),2) AS Profit
FROM sample_superstore
GROUP BY  Product_Name
ORDER BY Profit ASC
LIMIT 10;

-- Sales by Region
SELECT Region,
       ROUND(SUM(Sales),2) AS Sales
FROM sample_superstore
GROUP BY Region
ORDER BY Sales DESC;

-- Top 10 Customers
SELECT Customer_Name,
       ROUND(SUM(Sales),2) AS Sales
FROM sample_superstore
GROUP BY Customer_Name
ORDER BY Sales DESC
LIMIT 10;

-- Sales by State
SELECT State,
       ROUND(SUM(Sales),2) AS Sales
FROM sample_superstore
GROUP BY State
ORDER BY Sales DESC;

-- Sales by Segment
SELECT Segment,
       ROUND(SUM(Sales),2) AS Sales
FROM sample_superstore
GROUP BY Segment
ORDER BY Sales DESC;

-- Monthly Sales Trend
SELECT YEAR(Order_Date) AS Year,
       MONTH(Order_Date) AS Month,
       ROUND(SUM(Sales),2) AS Sales
FROM sample_superstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- Monthly Profit Trend
SELECT YEAR(Order_Date) AS Year,
       MONTH(Order_Date) AS Month,
       ROUND(SUM(Profit),2) AS Profit
FROM sample_superstore
GROUP BY Year, Month
ORDER BY Year, Month;

-- Average Discount by Category
SELECT Category,
       ROUND(AVG(Discount)*100,2) AS Avg_Discount_Percentage
FROM sample_superstore
GROUP BY Category;

-- Shipping Mode Usage
SELECT Ship_Mode,
       COUNT(*) AS Orders_Count
FROM sample_superstore
GROUP BY Ship_Mode
ORDER BY Orders_Count DESC;

-- Top 5 Cities by Profit
SELECT City,
       ROUND(SUM(Profit),2) AS Profit
FROM sample_superstore
GROUP BY City
ORDER BY Profit DESC
LIMIT 5;
-- Profit Margin by Category
SELECT Category,
       ROUND((SUM(Profit)/SUM(Sales))*100,2)
       AS Profit_Margin_Percentage
FROM sample_superstore
GROUP BY Category;