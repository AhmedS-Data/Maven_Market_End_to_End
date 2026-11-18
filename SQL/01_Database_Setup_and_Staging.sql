CREATE DATABASE MavenMarketDW
GO

USE MavenMarketDW
GO

CREATE SCHEMA stg;
GO

 CREATE TABLE stg.Calendar (
	[data] VARCHAR(20) 
);

BULK INSERT stg.Calendar 
FROM "D:\Data Analysis\02 - Projects\Maven_Market_End_to_End\Data\Processed\Calendar.csv"
WITH(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
	TABLOCK
);
GO


SELECT TOP 10 *
FROM stg.Calendar;



SELECT COUNT(*) AS TotalRows
FROM stg.Calendar;


CREATE TABLE stg.Customers (
    customer_id VARCHAR(50),
    customer_acct_num VARCHAR(50),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    customer_address VARCHAR(200),
    customer_city VARCHAR(100),
    customer_state_province VARCHAR(100),
    customer_postal_code VARCHAR(50),
    customer_country VARCHAR(100),
    birthdate VARCHAR(50),
    marital_status VARCHAR(20),
    yearly_income VARCHAR(50),
    gender VARCHAR(20),
    total_children VARCHAR(20),
    num_children_at_home VARCHAR(20),
    education VARCHAR(100),
    acct_open_date VARCHAR(50),
    member_card VARCHAR(30),
    occupation VARCHAR(100),
    homeowner VARCHAR(20)
);
GO


BULK INSERT stg.Customers 
FROM "D:\Data Analysis\02 - Projects\Maven_Market_End_to_End\Data\Processed\Customers.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);


CREATE TABLE stg.Products (
    product_id VARCHAR(50),
    product_brand VARCHAR(100),
    product_name VARCHAR(200),
    product_sku VARCHAR(50),
    product_retail_price VARCHAR(50),
    product_cost VARCHAR(50),
    product_weight VARCHAR(50),
    recyclable VARCHAR(20),
    low_fat VARCHAR(20)    
);

BULK INSERT stg.Products
FROM "D:\Data Analysis\02 - Projects\Maven_Market_End_to_End\Data\Processed\Products.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);


CREATE TABLE stg.Stores (
    store_id VARCHAR(50),
    region_id VARCHAR(50),
    store_type VARCHAR(50),
    store_name VARCHAR(100),
    store_street_address VARCHAR(200),
    store_city VARCHAR(100),
    store_state VARCHAR(100),
    store_country VARCHAR(100),
    store_phone VARCHAR(50),
    first_opened_date VARCHAR(50),
    last_remodel_date VARCHAR(50),
    total_sqft VARCHAR(50),
    grocery_sqft VARCHAR(50)
);


BULK INSERT stg.Stores
FROM "D:\Data Analysis\02 - Projects\Maven_Market_End_to_End\Data\Processed\Stores.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);


CREATE TABLE stg.Regions (
    region_id VARCHAR(50),
    sales_district VARCHAR(100),
    sales_region VARCHAR(100)
);


BULK INSERT stg.Regions 
FROM "D:\Data Analysis\02 - Projects\Maven_Market_End_to_End\Data\Processed\Regions.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);

CREATE TABLE stg.Transactions (
    transaction_date VARCHAR(50),
    stock_date VARCHAR(50),
    product_id VARCHAR(50),
    customer_id VARCHAR(50),
    store_id VARCHAR(50),
    quantity VARCHAR(50)
);

BULK INSERT stg.Transactions 
FROM "D:\Data Analysis\02 - Projects\Maven_Market_End_to_End\Data\Processed\Transactions(1997 - 1998).csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);



CREATE TABLE stg.Returns ( 
    return_date VARCHAR(50),
    product_id VARCHAR(50),
    store_id VARCHAR(50),
    quantity VARCHAR(50)
);


BULK INSERT stg.Returns 
FROM "D:\Data Analysis\02 - Projects\Maven_Markek_End_to_End\Data\Processed\Returns.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);