USE MavenMarketDW
GO


/* ==========================================
   Sales Analysis
   ========================================== */

-- Q1: What is the total quantity sold each year?

SELECT SUM(T.quantity) AS [Total Quantity], D.[year]
FROM dbo.FactTransactions AS T
JOIN dbo.DimDate D
ON T.transaction_date = D.[date]
GROUP BY D.[year]

/* `Insight`: Sales quantity increased by approximately 112.45% in 1998 compared to 1997,
indicating significant growth in sales volume.*/


-- Q2: What are the top 10 best-selling products based on total quantity sold?
SELECT TOP 10
P.product_name AS [Product Name],
SUM(T.quantity) AS [Total Quantity]
From dbo.DimProduct P
	join dbo.FactTransactions T
	ON P.product_id = T.product_id
GROUP BY P.product_name, P.product_id

ORDER BY [Total Quantity] DESC

/*
Insight: Tell Tale Fresh Lima Beans is the best-selling product with 698 units sold.
The top 10 products have relatively close sales volumes, ranging from 648 to 698 units.
*/

--> Q3: Top 10 Brands by Sales Volume

SELECT TOP 10
P.product_brand AS [Product Brand],
SUM(T.quantity) AS [Total Quantity]
From dbo.DimProduct P
	join dbo.FactTransactions T
	ON P.product_id = T.product_id
GROUP BY P.product_brand

ORDER BY [Total Quantity] DESC

/*
Insight: Hermanos leads all brands with 24,682 units sold, followed by Tell Tale and Ebony.
The top 10 brands show relatively close sales volumes.
*/

--> Q4: Which stores have the highest sales volume?
SELECT TOP 10 S.store_name AS [Store Name],
	SUM(T.quantity) AS [Total quantity]
FROM dbo.FactTransactions T
	JOIN dbo.DimStore S
	ON S.store_id = T.store_id
GROUP BY S.store_name
ORDER BY [Total quantity] DESC

/*
Insight: Store 13 leads in sales volume with 80,762 units sold, followed by Store 17.
There is a noticeable gap between the top two stores and the remaining stores.
*/

--> Q5: Which countries have the highest sales volume?
SELECT TOP 10 S.store_country AS [Store Country],
	SUM(T.quantity) AS [Total quantity]
FROM dbo.FactTransactions T
	JOIN dbo.DimStore S
	ON S.store_id = T.store_id
GROUP BY S.store_country
ORDER BY [Total quantity] DESC

/*
Insight: The USA leads in sales volume with 555,899 units sold,
accounting for the largest share of total sales quantity.
Mexico ranks second, followed by Canada.
*/

--> Q6: What are the top 10 most returned products?
SELECT TOP 10
    P.product_name AS [Product Name],
    SUM(R.quantity) AS [Total Returned Quantity]
FROM dbo.FactReturns AS R
JOIN dbo.DimProduct AS P
    ON R.product_id = P.product_id
GROUP BY P.product_id, P.product_name
ORDER BY [Total Returned Quantity] DESC;

/*
Insight: Hermanos Red Pepper is the most returned product with 17 units.
The top 10 returned products have relatively similar return quantities.
*/

--> Q7: Which countries have the highest return quantities?
SELECT
    S.store_country AS [Country],
    SUM(R.quantity) AS [Total Returned Quantity]
FROM dbo.FactReturns AS R
JOIN dbo.DimStore AS S
    ON R.store_id = S.store_id
GROUP BY S.store_country
ORDER BY [Total Returned Quantity] DESC;

/*
Insight: The USA has the highest returned quantity with 5,431 units,
followed by Mexico with 2,317 units and Canada with 541 units.
*/


--> Q8 What percentage of sold product quantity was returned in each country?
WITH Sales AS (
    SELECT
        S.store_country AS Country,
        SUM(T.quantity) AS TotalSold
    FROM dbo.FactTransactions AS T
    JOIN dbo.DimStore AS S
        ON T.store_id = S.store_id
    GROUP BY S.store_country
)
SELECT *
FROM Sales;

WITH Returns AS (
    SELECT
        S.store_country AS Country,
        SUM(R.quantity) AS TotalReturned
    FROM dbo.FactReturns AS R
    JOIN dbo.DimStore AS S
        ON R.store_id = S.store_id
    GROUP BY S.store_country
)
SELECT *
FROM Returns;

WITH Sales AS (
    SELECT
        S.store_country AS Country,
        SUM(T.quantity) AS TotalSold
    FROM dbo.FactTransactions AS T
    JOIN dbo.DimStore AS S
        ON T.store_id = S.store_id
    GROUP BY S.store_country
),
Returns AS (
    SELECT
        S.store_country AS Country,
        SUM(R.quantity) AS TotalReturned
    FROM dbo.FactReturns AS R
    JOIN dbo.DimStore AS S
        ON R.store_id = S.store_id
    GROUP BY S.store_country
)
SELECT
    S.Country,
    S.TotalSold,
    R.TotalReturned,
    CAST(
        R.TotalReturned * 100.0 / S.TotalSold
        AS DECIMAL(10,2)
    ) AS [Return Rate %]
FROM Sales AS S
JOIN Returns AS R
    ON S.Country = R.Country
ORDER BY [Return Rate %] DESC;

/*
Insight: Canada has the highest quantity-based return rate at 1.07%,
followed by Mexico at 1.02%.

The USA has the lowest return rate (0.98%), despite having the
highest returned quantity, because its sales volume is much larger.
*/