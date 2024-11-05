### LITA-Capstone-project
### Project Overview 
This project explores the sales performance analysis of a retail store.By analysing the various parameters in the data set, we seek to make reasonable decisions to enable the retail store maximise more profits and retain customers loyalty.

### Data Sources 
The primary data source in the provided Excel file, "LITA Capstone Dataset.xlsx," consists of sales data related to customer transactions. The dataset typically includes the following fields:

OrderID: A unique identifier for each order.

Customer Id: The identifier for each customer.

Product: The type of product sold (e.g., Shirt, Shoes, Hat).

Region: The geographical area where the sale occurred (e.g., North, South, East, West).

OrderDate: The date when the order was placed.

Quantity: The number of items sold in the order.

UnitPrice: The price per unit of the product.

The dataset provides valuable insights into sales performance and customer demographics for reporting and visualization purposes.

### Tools Used
The tools used for this project are : 
- Microsoft Excel for data cleaning, analysis and visualisation
- Structured Query Language (SQL) for querying of data
- Power BI for data visualisation
- Github for portfolio building and sharing.

### Data Cleaning and preparations 
For the data cleaning,the following were performed 
1. the salesdata and the customer data were structured by arranged by sorting the products and regions from A-Z
2. The total sales was also determined by multipling the Quantity by the unit price.
3. The products were also sorted with the product with the highest revenue.

### Exploratory Data Analysis 
Exploratory data analysis involved exploring the sales and customer data set to determine:
- Total sales by product 
- Total sales by region
- Total sales by month
- Subscription pattern
- Most popular subscription type

### Data Analysis 
In the data analysis using SQL the following codes were used:

*SALES DATA*

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


*CUSTOMER DATA*

SELECT * FROM customer_data;

-- 1.retrieve the total number of customers from each region.
SELECT
	Region,
	COUNT(CustomerID) AS unique_customers
FROM customer_data
GROUP BY region;

-- 2.find the most popular subscription type by the number of customers

SELECT
	SubscriptionType,
	COUNT(*) AS subscription_type_count
FROM 
	customer_data
GROUP BY 
	SubscriptionType
ORDER BY 
	subscription_type_count DESC
LIMIT 1;

    
-- 3.find customers who canceled their subscription within 6 months.
UPDATE 
	uloma_project.customer_data
SET
	SubscriptionStart = STR_TO_DATE(SubscriptionStart, '%d/%m/%Y'),
    SubscriptionEnd = STR_TO_DATE(SubscriptionEnd, '%d/%m/%Y'); -- Convert the subscriptionstart data type from text to date

SELECT 
	CustomerId, CustomerName
FROM customer_data
WHERE
	Canceled = 'TRUE' AND
    timestampdiff(MONTH, SubscriptionStart, SubscriptionEnd) <= 6;
    

-- 4.calculate the average subscription duration for all customers.
SELECT
	AVG(TIMESTAMPDIFF(MONTH, SubscriptionStart, SubscriptionEnd))
FROM 
	customer_data;
    
-- 5.find customers with subscriptions longer than 12 months.

SELECT 
	CustomerID, CustomerName
FROM customer_data
WHERE 
	TIMESTAMPDIFF(MONTH,SubscriptionStart, SubscriptionEnd) > 12;

-- 6.calculate total revenue by subscription type.
SELECT
	SubscriptionType,
	SUM(Revenue)
FROM
	customer_data
GROUP BY
	SubscriptionType;
    
-- 7.find the top 3 regions by subscription cancellations.
SELECT
	Region,
    COUNT(CustomerID) AS Canceled_Sub
FROM
customer_data
WHERE
	Canceled = 'TRUE'
GROUP BY Region
ORDER BY Canceled_Sub DESC
LIMIT 3;

-- 8.find the total number of active and canceled subscriptions.
SELECT Canceled, COUNT(CustomerID) AS Subscription_count
FROM
	customer_data
GROUP BY
	Canceled;
        
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

### Data Visualisation
The files uploaded shows the results obtained for Excel, SQL and PowerBI.

Exploring the results from these files, it reveals that the retail store in the South have the highest revenue for the year 2022 - 2023 with the shoes selling better than the other products. The West had the least revenue.

For the product performance analysis shows that the stores are selling more shoes than any other products.

The customers with the basic subscription generates more revenue for the store as they had the highest revenue compared to the premium and standard customers.

The retail store can engage in online advertisement to sensitive customers in the west, North and East and give more incentives to the customers to attract better sales in those regions.




