# Retail Sales Data Analysis

## 1. Introduction

This project involves analyzing retail sales data to uncover key business insights. The project includes scripts for calculating monthly average sales and identifying sales shifts.

SQL queries? Check them out here: [data_analysis](/data_analysis/)

## 2. Tools Used
- SQL: The backbone of my analysis, allowing me to query the database and unearth critical insights
- PostgreSQL: The database management system that stores the retail sales data.
- Git & GitHub: Version control and collaboration tools for tracking code changes and managing the project.

## 3. Analysis

Presenting the top 2 queries for the given data set, you can find the remaining queries at : [data_analysis](/data_analysis/)

### 1. Average Sale for Each Month and identify the Best-Selling Month Each Year

```sql
WITH avg_best_month AS (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale)) AS avg_sales,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY year, month
)
SELECT * FROM avg_best_month WHERE rank = 1;
```
Here's the breakdown of the query
- We use the EXTRACT function to get the year and month from the sale date
- The AVG function calculates the average sales for each month
- The RANK function is used to rank the months by average sales for each year, and only the top-ranked month (best-selling month) is returned



| Year | Month | Average Sales | Rank |
|------|-------|---------------|------|
| 2022 | 7     | 541           | 1    |
| 2023 | 2     | 536           | 1    |

*August from the year 2022 and February from the year 2023  stood as the best months*

### 2. Categorize Sales into Time Shifts and Count Orders per Shift

```sql
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
```
Here's the breakdown of the query

-  The EXTRACT(HOUR FROM sale_time) function extracts the hour of the sale, allowing us to categorize the time into shifts.
- The CASE statement defines the time ranges for each shift.
- The COUNT function tallies the total number of orders within each shift.

| Shift   | Order Count |
|---------|-------------|
| Evening | 1062        |
| Morning | 548         |
| Noon    | 377         |

 *Evening shift has the highest number of orders followed by Morning and Noon*

 ## 4. Things Learned

 - Enhanced skills in grouping and aggregating data using SQL.
 - Understood how to divide a day into operational shifts for more granular sales analysis.
 - Gained deeper insights into SQL query structuring and data analysis techniques.

 ## 6. Conclusions

1. Identified the best-selling month for each year, helping optimize stock and promotional campaigns.

2. SQL window functions like `RANK` and aggregate functions were essential for analyzing the data effectively.

3. The analysis offers actionable insights for operational efficiency, including adjusting staffing and inventory planning based on peak sales times.






