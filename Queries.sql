--- Understanding the data
SELECT COUNT(transaction_id)AS_number_of_sales
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE;

-- calcucation for the number of units sold
SELECT SUM(transaction_qty)AS_number_of_units_sold
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE;

-- calculation for revenue per transition
SELECT transaction_qty*unit_price AS revenue
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE;

-- calculating total revenue
SELECT SUM(transaction_qty*unit_price)AS_total_revenue
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE

--Revenue for product category
SELECT SUM(transaction_qty*unit_price)AS_total_revenue,
        product_category,
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE
GROUP BY product_category
ORDER BY AS_total_revenue DESC;

--the earliest time the shop opens
SELECT MIN(TRANSACTION_TIME)
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE

--the latest time the shop closes
SELECT MAX(TRANSACTION_TIME)
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE

-- Final query for the analysis
---Aggregate---
SELECT SUM(transaction_qty)AS_number_of_units_sold,
       SUM(transaction_qty*unit_price)AS_total_revenue,
       COUNT(transaction_id)AS_number_of_sales,
       
---Dates---  
       TO_CHAR(TRANSACTION_DATE,'YYYYMM')AS month_id,
       MONTHNAME(TRANSACTION_DATE)AS month_name,
       DAYNAME(TRANSACTION_DATE)AS day_name,
       
---Case Statements---      
CASE WHEN transaction_time BETWEEN '06:00:00'AND '11:59:59'THEN 'Morning'
     WHEN transaction_time BETWEEN '12:00:00'AND '15:59:59'THEN 'Afternoon'
     WHEN transaction_time BETWEEN '16:00:00'AND '20:00:00'THEN 'Evening'
     ELSE 'Night'
     END AS time_bucket,
CASE WHEN SUM(transaction_qty*unit_price)BETWEEN 0 AND 20 THEN 'Low'   
      WHEN SUM(transaction_qty*unit_price)BETWEEN 21 AND 40 THEN 'Medium' 
      WHEN SUM(transaction_qty*unit_price)BETWEEN 41 AND 60 THEN 'High'
      ELSE 'Very high'
      END AS spend_band,
      
---Grouping---      
     product_category,
     product_detail,
     product_type,
     store_location,   
FROM ADENIYI.TESTWORK.BRIGHT_COFFEE_STORE

---Group By Statement
GROUP BY product_category,
         product_detail,
         product_type,
         time_bucket,
         store_location,
         month_id,
         month_name
         day_name;
