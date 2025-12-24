CREATE DATABASE myntra_analysis;
USE myntra_analysis;


SELECT 
     COUNT(*) 
FROM myntra_cleaned;

-- Basics Analysis questions
-- Q1 Total Number of Products 
SELECT 
     COUNT(*) AS total_products
FROM myntra_cleaned;

-- Q2 Top 10  Brands by number of products 
SELECT 
     brand_name,
     COUNT(*) AS product_count
FROM myntra_cleaned
GROUP BY brand_name
ORDER BY product_count DESC;

-- Q3 Average price by category 
SELECT 
    brand_name,
    ROUND(AVG(price),2) AS Avg_price
FROM myntra_cleaned 
GROUP BY brand_name
ORDER BY Avg_price DESC; 

-- INTERMEDIATE ANALYST QUESTIONS
-- Q4. Brands with highest average rating (min 50 products)
SELECT 
     brand_name,
     ROUND(AVG(ratings),2) As Avg_ratings,
     COUNT(*) AS Total_products
FROM myntra_cleaned  
GROUP BY brand_name
HAVING COUNT(*) >= 50
ORDER BY Avg_ratings DESC;

-- Q5. Discount impact analysis
SELECT 
      CASE 
          WHEN discount_percent = 0 THEN "No Discount"
		  WHEN discount_percent BETWEEN 1 AND 30 THEN "Low Discount"
		  WHEN discount_percent BETWEEN 31 AND 60 THEN "Medium Discount"
		  ELSE "High"
		END AS discount_bucket,
        ROUND(AVG(ratings),2) AS avg_rating,
        COUNT(*) AS product_count
FROM myntra_cleaned
WHERE ratings IS NOT NULL 
GROUP BY discount_bucket;

-- ADVANCED ANALYST QUESTIONS (CTE + Window Functions)
-- Q6.Best value products (High rating + High discount)
SELECT 
     pants_description,
     brand_name,
     ratings,
     discount_percent,
     price
FROM myntra_cleaned
WHERE ratings >= 4.5 AND discount_percent >=40
ORDER BY ratings DESC, discount_percent DESC ;

