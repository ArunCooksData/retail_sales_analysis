-- SQL Retail Sales Analysis --



--CREATE TABLE--

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales

SELECT COUNT(*) FROM retail_sales

SELECT * FROM retail_sales
WHERE transactions_id IS NULL




-- DATA CLEANING--

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL
	

DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL


-- DATA EXPLORATIOM--


--HOW MANY SALES WE HAVE ?

SELECT COUNT(*) AS total_sales
FROM retail_sales


--HOW MANY UNIQUE CUSTOMERS WE HAVE ?

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales



--HOW MANY CATEGORIES WE HAVE ?

SELECT DISTINCT category AS total_categories
FROM retail_sales




-- DATA ANALYSIS  &  BUSINESS KEY PROBLEMS AND ANSWERS


-- My Analysis & Findings in the project

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT * FROM retail_sales
WHERE sale_date='2022-11-05'



-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
       --the quantity sold is more than 4 in the month of Nov-2022.


SELECT *
FROM retail_sales
WHERE category = 'Clothing' AND quantity>='4' AND TO_CHAR(sale_date,'YYYY-MM') ='2022-11'


-- Q.3 Write a SQL query to calculate the total sale (total_sales) for each category.

SELECT category ,SUM(total_sale) AS total_sales,COUNT(*) AS Total_orders
FROM retail_sales
GROUP BY 1


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT round(AVG(age),2) as Average_age
FROM retail_sales
WHERE category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale > '1000'


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender,COUNT(transactions_id) AS Total_transactions
FROM retail_sales
GROUP BY 1,2
ORDER BY 1


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

WITH my AS(
	SELECT 
	TO_CHAR(sale_date,'MM') as Monthh,
	TO_CHAR(sale_date,'YYYY') as Yearr, 
	AVG(total_sale) AS Average_sale,
	RANK() OVER(PARTITION BY TO_CHAR(sale_date,'YYYY') ORDER BY AVG(total_sale) DESC) as RANKK
	FROM retail_sales
	group by 1,2
	order by 2,3 DESC
)
SELECT monthh,yearr,average_sale
FROM my
WHERE rankk = '1'


--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id,SUM(total_sale) AS Total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,COUNT(DISTINCT customer_id) AS Count_of_unique_customers
FROM retail_sales
GROUP BY 1


-- Q.10 Write a SQL query to create each shift and number of orders 
	--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
	

WITH Hourly_sales AS (
	SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < '12' THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN '12' AND '17' THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales
)	
SELECT shift,COUNT(*) AS total_orders
FROM Hourly_sales
GROUP BY shift

--END OF THE PROJECT----







