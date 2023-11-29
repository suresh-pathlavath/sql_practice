
-- cleaned data result as follows
-- Created a new table named datamart_weekly_sales_cleaned as per the problem statement given in the following link
-- https://8weeksqlchallenge.com/case-study-5/

/*

    *******************    1. Data Cleansing Steps         *************************

CREATE TABLE datamart_weekly_sales_cleaned AS
SELECT
  week_date,
  WEEK(week_date) AS week_number,
  DATE_FORMAT(week_date, '%m') AS month_number,
  DATE_FORMAT(week_date, '%Y') AS calendar_year,
  segment,
  CASE
    WHEN segment = 'null' THEN 'unknown'
    ELSE REGEXP_REPLACE(segment, '[^0-9]', '')
  END AS extracted_number,
  CASE
    WHEN segment = 'null' THEN 'unknown'
    ELSE REGEXP_REPLACE(segment, '[^a-zA-Z]', '')
  END AS extracted_text,
  CASE
    WHEN REGEXP_REPLACE(segment, '[^0-9]', '') = 1 THEN 'Young Adults'
    WHEN REGEXP_REPLACE(segment, '[^0-9]', '') = 2 THEN 'Middle Aged'
    WHEN REGEXP_REPLACE(segment, '[^0-9]', '') IN (3, 4) THEN 'Retirees'
    ELSE 'unknown'
  END AS age_band,
  CASE
    WHEN REGEXP_REPLACE(segment, '[^a-zA-Z]', '') = 'C' THEN 'Couples'
    WHEN REGEXP_REPLACE(segment, '[^a-zA-Z]', '') = 'F' THEN 'Families'
    ELSE 'unknown'
  END AS demographic,
  region, platform, 
  customer_type,
  transactions,
  sales,
  ROUND(sales * 1.0 / transactions, 2) AS avg_transaction
FROM
  datamart_weekly_sales;

  ******************************            END         *******************************
*/

SELECT * FROM  datamart_weekly_sales_cleaned LIMIT 50;
SELECT * FROM datamart_weekly_sales LIMIT 100;

--              ***************************     2. Data Exploration     ****************************

-- 01. What day of the week is used for each week_date value?
        SELECT DISTINCT
        DAYNAME(week_date) AS day_of_week
        FROM
        datamart_weekly_sales_cleaned;

-- 02. What range of week numbers are missing from the dataset?

        SELECT DISTINCT
        WEEK(week_date) AS weekdate
        FROM
        datamart_weekly_sales_cleaned
        ORDER BY
        WEEK(week_date);

-- 03. How many total transactions were there for each year in the dataset?
        SELECT
        YEAR(week_date) AS year,
        SUM(transactions) AS total_transactions
        FROM
        datamart_weekly_sales_cleaned
        GROUP BY
        1
        ORDER BY
        YEAR(week_date);

-- 04. What is the total sales for each region for each month?
        
        SELECT
        region,
        DATE_FORMAT(week_date, '%m') AS month_number,
        DATE_FORMAT(week_date, '%M') AS sales_month,
        SUM(sales) AS total_sales
        FROM
        datamart_weekly_sales_cleaned
        GROUP BY
        1, 2, 3
        ORDER BY
        1, 2, 3;

-- 05. What is the total count of transactions for each platform
        


  SELECT * FROM  datamart_weekly_sales_cleaned LIMIT 50;
