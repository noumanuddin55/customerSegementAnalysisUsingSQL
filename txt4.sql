show databases;
use online_retail;
-- select count(*) from online_retail;

/* Basic Query=1

What is the distribution of order values across all customers in the dataset?

SELECT CustomerID, SUM(Quantity) total_order_values
FROM online_retail
GROUP BY CustomerID 
*/

/*
Basic Query=2
How many unique products has each customer purchased?

SELECT
    CustomerID,
    COUNT(DISTINCT StockCode) UniqueProductCount
FROM
    online_retail
GROUP BY
    CustomerID;
*/

/*
basic query 3
Which customers have only made a single purchase from the company?

SELECT
    CustomerID
FROM
    online_retail
GROUP BY
    CustomerID
HAVING
    COUNT(DISTINCT InvoiceNo) = 1;
*/


#basic query 4
-- select stockcode,count(stockcode) as purchasedcount
-- from
-- online_retail
-- group by stockcode
-- order by purchasedcount desc;

/*
basic query 5
Which products are most commonly purchased together by customers in the dataset?

SELECT
    StockCode,
    COUNT(*) AS PurchaseCount
FROM
    online_retail 
    
GROUP BY
    stockcode
ORDER BY
    PurchaseCount DESC;
*/

#Advance Queries
/* adv query 1
Group customers into segments based on their purchase frequency, such as high, medium, and low frequency customers. 
This can help you identify your most loyal customers
 and those who need more attention.

SELECT
    CustomerID,
    PurchaseFrequency,
    CASE
        WHEN PurchaseFrequency >= 80 THEN 'High'
        WHEN PurchaseFrequency >= 40 THEN 'Medium'
        ELSE 'Low'
    END AS FrequencySegment
FROM (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS PurchaseFrequency,
        ROW_NUMBER() OVER (ORDER BY COUNT(DISTINCT InvoiceNo) DESC) AS FrequencyRank
    FROM
        online_retail
    GROUP BY
        CustomerID
) AS PurchaseFrequencySubquery;
*/


/* adv query 2
Calculate the average order value for each country to identify where your most valuable customers are located.

SELECT
    Country,
    AVG(Quantity * UnitPrice)  AvgOrderValue
FROM
    online_retail
GROUP BY
    Country
ORDER BY
    AvgOrderValue DESC;
*/

/* adv query 3
Identify customers who haven't made a purchase in a specific period (e.g., last 6 months) to assess churn

SELECT
    CustomerID
FROM
    online_retail
WHERE
    InvoiceDate <= NOW() - INTERVAL 9 MONTH 
GROUP BY
    CustomerID;
*/

/*adv query 4
 Explore trends in customer behavior over time, such as monthly or quarterly sales patterns.
 
monthly sales 
SELECT
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    SUM(Quantity * UnitPrice) AS MonthlySales
FROM
    online_retail
GROUP BY
    Year, Month
ORDER BY
    Year, Month;
    
    
quarterly sales
SELECT
    YEAR(InvoiceDate) AS Year,
    QUARTER(InvoiceDate) AS Quarter,
    SUM(Quantity * UnitPrice) AS QuarterlySales
FROM
    online_retail
GROUP BY
    Year, Quarter
ORDER BY
    Year, Quarter;
*/


-- adv query 5
-- Determine which products are often purchased together by calculating the correlation between product purchases

SELECT
    A.StockCode AS Product1,
    B.StockCode AS Product2,
    COUNT(DISTINCT A.InvoiceNo) AS PurchaseCount
FROM
    online_retail A
JOIN
    online_retail B ON A.InvoiceNo = B.InvoiceNo AND A.StockCode < B.StockCode
GROUP BY
    Product1, Product2;




    
    