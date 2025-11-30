-- Sql Retail Sales Analysis
CREATE DATABASE sql_pro1;

-- Creating table
CREATE TABLE Retail_sales
      (
        transactions_id INT,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
		category VARCHAR(15),
		quantiy INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
       );
SELECT * FROM Retail_sales
WHERE 
     customer_id IS NULL
	 OR
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
	 age IS NULL
	 OR
	 category IS NULL
	 OR
     quantiy IS NULL
	 OR
     price_per_unit IS NULL
	 OR
	 cogs IS NULL;
DELETE FROM Retail_sales
WHERE 
      customer_id IS NULL
	 OR
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
	 age IS NULL
	 OR
	 category IS NULL
	 OR
     quantiy IS NULL
	 OR
     price_per_unit IS NULL
	 OR
	 cogs IS NULL;
-- DATA EXPLORATION

-- QUES.1: HOW MANY SALES WE HAVE?
SELECT COUNT(*) as total_sale FROM Retail_sales 

-- QUES.2: HOW MANY UNIQUE CUSTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id ) FROM Retail_sales 

-- QUES.3: HOW MANY DIFFERENT CATEGORY PRODUCTS WE HAVE
SELECT  DISTINCT category  FROM Retail_sales 

-- Data Analysis & Key Business Problems with Answers

-- Q1: write a sql query to retrieve all the sales done n 2022-10-15
SELECT * FROM Retail_sales
WHERE sale_date = '2022-11-05';

-- Q2: write a sql query to retrive all the sales in category 'clothing' and the quantity sold is more than 2 in month of november-2022
SELECT * FROM Retail_sales 
WHERE
     category = 'Clothing'
	 AND 
	 '2022-10-31' < sale_date 
	 AND
	 sale_date < '2022-12-01'
	 AND 
	 quantiy > 2;

-- Q3: write a sql query to get total sales of each category
SELECT category,SUM(total_sale) AS ts FROM Retail_sales GROUP BY category ORDER BY 1 DESC

-- Q4: write a sql query to find the average age of the customers from 'beauty' categoRY
SELECT AVG(age) AS average_age FROM Retail_sales WHERE category = 'Beauty'

-- Q5: write a sql query to get all the transactions where  total_sale is greater than 1000
SELECT * FROM Retail_sales 
WHERE total_sale > 1000

-- Q6: write a sql query to find total no. of transactions(transactions_id) made by each gender in each category
SELECT COUNT(transactions_id) AS total_num, category, gender FROM Retail_sales GROUP BY category, gender 

-- Q7: write a sql query to calculate the average sale for each month. find out best selling month in each year
SELECT 
      year,
	  month,
	  average_sale
	  FROM
	  (
      SELECT 	
            EXTRACT(YEAR FROM sale_date ) AS year,
	        EXTRACT(MONTH FROM sale_date ) AS month,
	        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC ) AS rank,
	        AVG(total_sale) AS average_sale
	        FROM Retail_sales
	        GROUP BY 1,2
	  ) AS t1
WHERE rank=1;	

--Q8: write a sql query to find the top 5 customer based on the highest total sales
SELECT customer_id,
SUM(total_sale) AS total_sales
FROM Retail_sales
GROUP BY 1
ORDER BY total_sales DESC LIMIT 5;

--Q9: write a query to find the number of unique customers who have purchased from each category
SELECT category, COUNT( DISTINCT customer_id) AS Unique_customer
FROM Retail_sales
GROUP BY category 

--Q10: write a sql query to create each shift and no. of orders ( Example morning < 12, afternoon between 12 & 17, Evening > 17 )
SELECT
      shift,
	  COUNT(*) AS total_orders
	  FROM
           (SELECT *,
                     CASE   
                         WHEN EXTRACT(HOUR FROM sale_time)< 12 THEN 'MORNING'
	                     WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		                 ELSE 'Evening'
                     END AS shift		  
	                 FROM Retail_sales
		   ) AS t2
		 GROUP BY shift  

-- END OF PROJECT
	  
	   