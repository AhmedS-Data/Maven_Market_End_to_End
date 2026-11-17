USE MavenMarketDW;
GO

SELECT 'DimCustomer' AS TableName, COUNT(*) AS TotalRows
FROM dbo.DimCustomer

UNION ALL

SELECT 'DimProduct', COUNT(*)
FROM dbo.DimProduct

UNION ALL

SELECT 'DimStore', COUNT(*)
FROM dbo.DimStore

UNION ALL

SELECT 'DimDate', COUNT(*)
FROM dbo.DimDate

UNION ALL

SELECT 'FactTransactions', COUNT(*)
FROM dbo.FactTransactions

UNION ALL

SELECT 'FactReturns', COUNT(*)
FROM dbo.FactReturns;
--================================================================--
--> Create FactTransaction TAble


CREATE TABLE dbo.FactTransactions (
    transaction_date DATE NOT NULL,
    stock_date DATE NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    quantity INT NOT NULL,
);

--> Load Data From stg.transaction
INSERT INTO dbo.FactTransactions (
    transaction_date,
    stock_date,
    product_id,
    customer_id,
    store_id,
    quantity
)
SELECT
    TRY_CONVERT(DATE, TRIM(REPLACE(transaction_date, CHAR(13), '')), 23),
    TRY_CONVERT(DATE, TRIM(REPLACE(stock_date, CHAR(13), '')), 23),
    TRY_CONVERT(INT, TRIM(REPLACE(product_id, CHAR(13), ''))),
    TRY_CONVERT(INT, TRIM(REPLACE(customer_id, CHAR(13), ''))),
    TRY_CONVERT(INT, TRIM(REPLACE(store_id, CHAR(13), ''))),
    TRY_CONVERT(INT, TRIM(REPLACE(quantity, CHAR(13), '')))
FROM stg.Transactions;


SELECT COUNT(*) AS TotalRows
FROM dbo.FactTransactions;

SELECT
    COUNT(*) AS TotalRows,
    SUM(quantity) AS TotalQuantity,
    MIN(transaction_date) AS FirstTransactionDate,
    MAX(transaction_date) AS LastTransactionDate
FROM dbo.FactTransactions;

--==============================================================--
-->Create FactReturn Table

CREATE TABLE dbo.FactReturns (
    return_date DATE NOT NULL,
    product_id INT NOT NULL,
    store_id INT NOT NULL,
    quantity INT NOT NULL
);

INSERT INTO dbo.FactReturns (
    return_date,
    product_id,
    store_id,
    quantity
)
SELECT
    TRY_CONVERT(DATE, TRIM(REPLACE(return_date, CHAR(13), '')), 23),
    TRY_CONVERT(INT, TRIM(REPLACE(product_id, CHAR(13), ''))),
    TRY_CONVERT(INT, TRIM(REPLACE(store_id, CHAR(13), ''))),
    TRY_CONVERT(INT, TRIM(REPLACE(quantity, CHAR(13), '')))
FROM stg.Returns;

SELECT
    COUNT(*) AS TotalReturnRecords,
    SUM(quantity) AS TotalReturnedQuantity,
    MIN(return_date) AS FirstReturnDate,
    MAX(return_date) AS LastReturnDate
FROM dbo.FactReturns;

-----------------------------------------------------------
--> Realations With FactTransactions <--

ALTER TABLE dbo.FactTransactions
ADD CONSTRAINT FK_FactTransactions_DimCustomer
FOREIGN KEY (customer_id)
REFERENCES dbo.DimCustomer(customer_id);

ALTER TABLE dbo.FactTransactions
ADD CONSTRAINT FK_FactTransactions_DimProduct
FOREIGN KEY (product_id)
REFERENCES dbo.DimProduct(product_id);

ALTER TABLE dbo.FactTransactions
ADD CONSTRAINT FK_FactTransaction_DimStore
FOREIGN KEY (store_id)
REFERENCES dbo.DimStore(store_id)

ALTER TABLE dbo.FactTransactions
ADD CONSTRAINT FK_FactTransactions_DimDate
FOREIGN KEY (transaction_date)
REFERENCES dbo.DimDate([date]);

-----------------------------------------------------------
--> Realations With FactReturns <--

ALTER TABLE dbo.FactReturns
ADD CONSTRAINT FK_FactReturns_DimProduct
FOREIGN KEY (product_id)
REFERENCES dbo.DimProduct(product_id);

ALTER TABLE dbo.FactReturns
ADD CONSTRAINT FK_FactReturns_DimStore
FOREIGN KEY (store_id)
REFERENCES dbo.DimStore(store_id);

ALTER TABLE dbo.FactReturns
ADD CONSTRAINT FK_FactReturns_DimDate
FOREIGN KEY (return_date)
REFERENCES dbo.DimDate([date]);


SELECT
    OBJECT_NAME(parent_object_id) AS FactTable,
    name AS ForeignKeyName,
    OBJECT_NAME(referenced_object_id) AS DimensionTable
FROM sys.foreign_keys
ORDER BY FactTable, ForeignKeyName;

USE master;
GO

ALTER AUTHORIZATION
ON DATABASE::MavenMarketDW
TO sa;
GO