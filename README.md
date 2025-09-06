# 📊 Instamart Data Analytics

Welcome to the **Instamart Data Analytics** project! This project uses **SQL** to clean, explore, and analyze grocery order data from Instamart. The insights generated here help businesses optimize inventory, understand customer behavior, and make data-driven decisions.

---

## 📂 Project Overview

In today's fast-paced grocery delivery ecosystem, platforms like Instamart need to process large datasets efficiently to track sales trends, customer preferences, and outlet performance. This project focuses on:

- **Data Cleaning**: Handling inconsistent entries in product details.
- **Key Performance Indicators (KPIs)**: Summarizing sales, ratings, and orders.
- **Sales Analysis**: Exploring sales across products, outlets, and regions.
- **Pivot Analysis**: Comparing sales between categories like Low Fat and Regular items.

The goal is to extract actionable insights using SQL queries that are efficient, scalable, and easy to understand.

---

## 📂 Technologies Used

- **SQL Server Management Studio (SSMS)** – for writing and executing SQL scripts
- **SQL (Structured Query Language)** – for data manipulation and analysis
- **GitHub** – for version control and collaboration

---

## 🧱 Database Schema

The database is named `Instamart_Data` and contains the following important columns:

| Column Name             | Description                       |
|------------------------|-----------------------------------|
| `Order_ID`              | Unique identifier for each order |
| `Item_Fat_Content`      | Indicates whether the item is low fat or regular |
| `Item_Type`             | Category of the item             |
| `Outlet_Location_Type`  | Type of outlet location         |
| `Outlet_Size`           | Size of the outlet              |
| `Outlet_Type`           | Type of outlet                 |
| `Outlet_Establishment_Year` | Year when the outlet was established |
| `Total_Sales`           | Total amount of the order     |
| `Rating`                | Customer rating for the order |

---

## ✅ How to Run the Project

1. Clone the repository or download the files.
2. Open the project folder in **SQL Server Management Studio**.
3. Open the `Instamart_Data_Analytics.sql` file.
4. Execute queries one by one or as a whole script.
5. Explore the results and use them to derive insights.

---

## 📜 SQL Code Example

Here’s a snippet from the project showing how data cleaning is performed:

```sql
-- Clean inconsistent entries in Item_Fat_Content column
UPDATE Instamart_Data
SET Item_Fat_Content = 
    CASE
        WHEN LOWER(Item_Fat_Content) IN ('lf', 'low fat') THEN 'Low Fat'
        WHEN LOWER(Item_Fat_Content) = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

-- Verify that the values have been standardized
SELECT DISTINCT Item_Fat_Content FROM Instamart_Data;
