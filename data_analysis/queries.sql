/* 1.SQL Query to retrieve all columns for sales on '2022-11-05' */

SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

/*
2. SQL query to retrieve all transactions where the category is 'Clothing'
    and the quantity is more than 3 in the month of 'Nov 2022'
*/


SELECT 
    *
FROM
    retail_sales
WHERE 
    category = 'Clothing' AND
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND
    quantity > 3;


/* 3. SQL query to calculate the total sales for each category */

SELECT
    category,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

/* 4. Query to find the average age of customers who purchased items from the 'Beauty' Category */

SELECT * FROM retail_sales LIMIT 5;

SELECT
    ROUND(AVG(age)) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

/* 5. Query to find all transactions where the total_sale is greater than 1000. */

SELECT  
    *
FROM retail_sales
WHERE
    total_sale > 1000;

/* 6. Query to find the total number of transactions made by each gender in respective category */

SELECT
    gender,
    category,
    COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY gender;

/* 7. Query to calculate the average sale for each month. Find out best selling month in each year */



WITH avg_best_month AS(
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale)) AS avg_sales,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY year, month
)
SELECT * FROM avg_best_month WHERE rank = 1



/* 8. Query to find the top 5 customers based on the highest total sales */

SELECT
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


/* 9. Query to find the number of unique customers who purchased items from each category. */

SELECT 
    COUNT(DISTINCT(customer_id)),
    category
FROM
    retail_sales
GROUP BY category;


/* 10. Query to create each shift and number of orders (i.e morning <= 12, noon between 12 & 17, eve > 17). */

SELECT * FROM retail_sales LIMIT 5;


SELECT 
    CASE
       WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'noon'
        ELSE 'evening'
    END AS shift,
    COUNT(transaction_id)
FROM retail_sales
GROUP BY shift
ORDER BY COUNT(transaction_id) DESC;

