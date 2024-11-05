USE uloma_project;

SELECT * FROM sales_data;

-- 1.retrieve the total sales for each product category.
SELECT 
	Product,
    SUM(Revenue) AS Total_Sales
FROM
	sales_data
GROUP BY
	Product;
    
-- 2.find the number of sales transactions in each region.
SELECT 
	Region,
    COUNT(*) AS Num_of_sales_trans
FROM
	sales_data
GROUP BY 
	region;

-- 3.find the highest-selling product by total sales value.
SELECT 
	Product,
    SUM(Revenue) AS Total_Sales
FROM
	sales_data
GROUP BY
	Product
ORDER BY 
	Total_Sales DESC
LIMIT 1;

-- 4. calculate total revenue per product.
SELECT 
	Product,
    SUM(Revenue) AS Total_Sales
FROM
	sales_data
GROUP BY
	Product;
    
-- 5.calculate monthly sales totals for the current year
-- Convert the column date datatype from string to date
UPDATE 
	uloma_project.sales_data
SET 
	OrderDate = STR_TO_DATE(OrderDate, '%d/%m/%Y');
 
SELECT 
	MONTH(OrderDate),
    SUM(Revenue) AS Total_Sales
FROM
	sales_data
WHERE 
	YEAR(OrderDate) = YEAR(curdate())
GROUP BY
	MONTH(OrderDate)
ORDER BY 
	Month(OrderDate) ASC;
    
-- 6.find the top 5 customers by total purchase amount.
SELECT 
	`Customer Id`, -- `` Th eback quote was used becuase of the space in the column name Customer ID
    SUM(Revenue) AS Total_Sales
FROM
	sales_data
GROUP BY
	`Customer Id`
ORDER BY 
	Total_Sales DESC
LIMIT 5;

-- 7.calculate the percentage of total sales contributed by each region.
SELECT
	region,
    SUM(Revenue) AS Revenue,
    (
		SUM(Revenue) / (SELECT SUM(Revenue) FROM sales_data)* 100
        ) AS percentage_total
FROM
	sales_data
GROUP BY 
	Region;
    
-- 8.identify products with no sales in the last quarter.
        
SELECT 
    DISTINCT s1.Product
FROM 
    sales_data s1
LEFT JOIN 
    sales_data s2 
ON 
    s1.Product = s2.Product 
    AND s2.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
WHERE 
    s2.Product IS NULL;
