USE MavenMarketDW;
GO
-------------------------------------------------
CREATE TABLE dbo.DimCustomer (
    customer_id INT PRIMARY KEY,
    customer_acct_num BIGINT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    customer_address VARCHAR(150),
    customer_city VARCHAR(50),
    customer_state_province VARCHAR(50),
    customer_postal_code VARCHAR(20),
    customer_country VARCHAR(50),
    birthdate DATE,
    marital_status VARCHAR(10),
    yearly_income VARCHAR(30),
    gender VARCHAR(10),
    total_children INT,
    num_children_at_home INT,
    education VARCHAR(50),
    acct_open_date DATE,
    member_card VARCHAR(20),
    occupation VARCHAR(50),
    homeowner VARCHAR(5)
);


INSERT INTO dbo.DimCustomer (
    customer_id,
    customer_acct_num,
    first_name,
    last_name,
    customer_address,
    customer_city,
    customer_state_province,
    customer_postal_code,
    customer_country,
    birthdate,
    marital_status,
    yearly_income,
    gender,
    total_children,
    num_children_at_home,
    education,
    acct_open_date,
    member_card,
    occupation,
    homeowner
)

SELECT
    TRY_CONVERT(INT, TRIM(customer_id)),
    TRY_CONVERT(BIGINT, TRIM(customer_acct_num)),
    first_name,
    last_name,
    customer_address,
    customer_city,
    customer_state_province,
    customer_postal_code,
    customer_country,
    TRY_CONVERT(DATE, TRIM(REPLACE(birthdate, CHAR(13), '')), 23),
    marital_status,
    yearly_income,
    gender,
    TRY_CONVERT(INT, TRIM(total_children)),
    TRY_CONVERT(INT, TRIM(num_children_at_home)),
    education,
    TRY_CONVERT(DATE, TRIM(REPLACE(acct_open_date, CHAR(13), '')), 23),
    member_card,
    occupation,
    homeowner

FROM stg.Customers;
-------------------------------------------------
-- Create DimProduct Table
CREATE TABLE dbo.DimProduct (
    product_id INT PRIMARY KEY,
    product_brand VARCHAR(100),
    product_name VARCHAR(200),
    product_sku VARCHAR(50),
    product_retail_price DECIMAL(10,2),
    product_cost DECIMAL(10,2),
    product_weight DECIMAL(10,2),
    recyclable BIT NULL,
    low_fat BIT NULL
);

-- Load data into DimProduct
INSERT INTO dbo.DimProduct (
    product_id,
    product_brand,
    product_name,
    product_sku,
    product_retail_price,
    product_cost,
    product_weight,
    recyclable,
    low_fat
)
SELECT 
    product_id,
    product_brand,
    product_name,
    product_sku,
    product_retail_price,
    product_cost,
    product_weight,
    TRY_CONVERT(BIT,TRIM(recyclable)),
    TRY_CONVERT(BIT,TRIM(low_fat))
FROM stg.Products;



SELECT COUNT(*) AS TotalProducts
FROM dbo.DimProduct;


-------------------------------------------------
CREATE TABLE dbo.DimStore (
    store_id INT PRIMARY KEY,
    region_id INT,
    store_type VARCHAR(50),
    store_name VARCHAR(100),
    store_street_address VARCHAR(150),
    store_city VARCHAR(50),
    store_state VARCHAR(50),
    store_country VARCHAR(50),
    store_phone VARCHAR(30),
    first_opened_date DATE,
    last_remodel_date DATE,
    total_sqft INT,
    grocery_sqft INT,
    sales_district VARCHAR(100),
    sales_region VARCHAR(100)
);


INSERT INTO dbo.DimStore (
    store_id,
    region_id,
    store_type,
    store_name,
    store_street_address,
    store_city,
    store_state,
    store_country,
    store_phone,
    first_opened_date,
    last_remodel_date,
    total_sqft,
    grocery_sqft,
    sales_district,
    sales_region
)
SELECT 
    TRY_CONVERT(INT,s.store_id),
    TRY_CONVERT(INT,s.region_id),
    store_type,
    store_name,
    store_street_address,
    store_city,
    store_state,
    store_country,
    store_phone,
    TRY_CONVERT(DATE,s.first_opened_date),
    TRY_CONVERT(DATE,s.last_remodel_date),
    TRY_CONVERT(INT,s.total_sqft),
    TRY_CONVERT(INT,s.grocery_sqft),
    sales_district,
    sales_region

FROM stg.Stores s
    JOIN stg.Regions r
    ON s.region_id = r.region_id;

--------------------------------------------------
CREATE TABLE dbo.DimDate (
    [date] DATE PRIMARY KEY,
    [year] INT,
    [quarter] INT,
    [month] INT,
    [month_name] VARCHAR(20),
    [day] INT,
    [day_name] VARCHAR(20)
);


-- Load data into DimDate

INSERT INTO dbo.DimDate (
    [date],
    [year],
    [quarter],
    [month],
    [month_name],
    [day],
    [day_name]
)

SELECT
    d.DateValue,
    YEAR(d.DateValue),
    DATEPART(QUARTER, d.DateValue),
    MONTH(d.DateValue),
    DATENAME(MONTH, d.DateValue),
    DAY(d.DateValue),
    DATENAME(WEEKDAY, d.DateValue)

FROM stg.Calendar AS c

CROSS APPLY (
    SELECT
        TRY_CONVERT(
            DATE,
            TRIM(REPLACE(c.[date], CHAR(13), '')),
            23
        ) AS DateValue
) AS d

WHERE d.DateValue IS NOT NULL;


-- Verify loaded data

SELECT
    COUNT(*) AS TotalRows,
    MIN([date]) AS FirstDate,
    MAX([date]) AS LastDate
FROM dbo.DimDate;

--------------------------------------------------
