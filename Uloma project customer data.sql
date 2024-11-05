USE uloma_project;

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