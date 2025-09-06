-- ================================================
-- Instamart Data Analytics SQL Script
-- Purpose: Data cleaning, KPI generation, and sales analysis
-- Database: Instamart_Data
-- ================================================


 -- 1. VIEW ALL DATA
-- Inspect the entire dataset
SELECT * 
FROM Instamart_Data;


-- 2. DATA CLEANING
-- Standardize the Item_Fat_Content column to ensure consistency

UPDATE Instamart_Data
SET Item_Fat_Content = 
    CASE
        WHEN LOWER(Item_Fat_Content) IN ('lf', 'low fat') THEN 'Low Fat'
        WHEN LOWER(Item_Fat_Content) = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

-- Verify that the values are cleaned
SELECT DISTINCT Item_Fat_Content 
FROM Instamart_Data;


-- 3. KEY PERFORMANCE INDICATORS (KPIs)

-- Total Sales in millions
SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM Instamart_Data;

-- Average Sales per order
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales
FROM Instamart_Data;

-- Total number of orders
SELECT COUNT(Order_ID) AS No_of_Orders
FROM Instamart_Data;

-- Average customer rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Instamart_Data;


-- 4. SALES BY FAT CONTENT
-- Aggregate sales grouped by Item_Fat_Content
SELECT Item_Fat_Content, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM Instamart_Data
GROUP BY Item_Fat_Content;


-- 5. SALES BY ITEM TYPE
-- Aggregate and format sales grouped by Item_Type
SELECT Item_Type, 
       FORMAT(SUM(Total_Sales), 'N2') AS Total_Sales
FROM Instamart_Data
GROUP BY Item_Type
ORDER BY SUM(Total_Sales) DESC;


-- 6. SALES BY FAT CONTENT FOR EACH OUTLET LOCATION (Pivot Table)
SELECT Outlet_Location_Type,
       COALESCE([Low Fat], 0) AS Low_Fat_Sales,
       COALESCE([Regular], 0) AS Regular_Sales
FROM (
    SELECT Outlet_Location_Type, Item_Fat_Content, SUM(Total_Sales) AS Sales
    FROM Instamart_Data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceData
PIVOT (
    SUM(Sales) FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotResult
ORDER BY Outlet_Location_Type;


-- 7. SALES BY OUTLET ESTABLISHMENT YEAR
SELECT Outlet_Establishment_Year, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM Instamart_Data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;


-- 8. SALES PERCENTAGE BY OUTLET SIZE
WITH TotalSales AS (
    SELECT SUM(Total_Sales) AS GrandTotal FROM Instamart_Data
)
SELECT Outlet_Size,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Total_Sales) * 100.0 / (SELECT GrandTotal FROM TotalSales)) AS DECIMAL(10,2)) AS Sales_Percentage
FROM Instamart_Data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;


-- 9. SALES PERCENTAGE BY OUTLET TYPE
WITH TotalSales AS (
    SELECT SUM(Total_Sales) AS GrandTotal FROM Instamart_Data
)
SELECT Outlet_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Total_Sales) * 100.0 / (SELECT GrandTotal FROM TotalSales)) AS DECIMAL(10,2)) AS Sales_Percentage
FROM Instamart_Data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;


-- 10. SALES PERCENTAGE BY OUTLET LOCATION
WITH TotalSales AS (
    SELECT SUM(Total_Sales) AS GrandTotal FROM Instamart_Data
)
SELECT Outlet_Location_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Total_Sales) * 100.0 / (SELECT GrandTotal FROM TotalSales)) AS DECIMAL(10,2)) AS Sales_Percentage
FROM Instamart_Data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;


-- 11. COMPREHENSIVE METRICS BY OUTLET TYPE
SELECT Outlet_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,2)) AS Avg_Sales,
       COUNT(Order_ID) AS No_of_Orders,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM Instamart_Data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;


-- ================================================
-- End of Instamart Data Analytics SQL Script
-- ================================================
