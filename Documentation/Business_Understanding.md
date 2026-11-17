# Business Understanding – Maven Market

## 1. Project Overview

Maven Market is a fictional international grocery retailer operating across the United States, Canada, and Mexico.

This project aims to analyze the company's sales, customers, products, stores, and product returns using the provided datasets.

The main goal is to transform raw business data into meaningful insights that can help understand business performance and support better decision-making.

## 2. Business Problem

The available data is distributed across multiple tables, including transactions, customers, products, stores, and returns.

Analyzing these datasets separately makes it difficult to understand the overall business performance.

This project brings the data together to investigate business performance and answer important questions related to sales, products, customers, stores, and returns.

## 3. Project Objectives

The main objectives are:

1. Understand the structure and quality of the available datasets.
2. Clean and prepare the data using Python and Pandas.
3. Combine the 1997 and 1998 transaction datasets into one table.
4. Design a Data Warehouse using a dimensional data model.
5. Store the prepared data in SQL Server.
6. Perform business analysis using SQL.
7. Build an interactive dashboard using Power BI.
8. Present meaningful insights and recommendations based on the analysis.

## 4. Stakeholders

The analysis is intended to support different business stakeholders:

- **Business Management:** Monitor overall business performance.
- **Sales Managers:** Evaluate sales performance across stores and regions.
- **Product Managers:** Identify top-performing and low-performing products.
- **Store Managers:** Understand store performance and product returns.
- **Marketing Teams:** Explore customer characteristics and purchasing patterns.

These are potential stakeholder groups identified for this analytical project.

## 5. Dataset Scope

The project uses seven logical tables:

| Table | Description |
|---|---|
| Calendar | Date information used for time-based analysis. |
| Customers | Customer profiles and demographic information. |
| Products | Product details, categories, and pricing information. |
| Regions | Sales district and region information. |
| Stores | Store details and location-related information. |
| Transactions | Product purchase records from 1997 and 1998. |
| Returns | Records of products returned to stores. |

The two transaction files are combined into one Transactions dataset during data preparation.

## 6. Key Business Metrics

The following metrics will be considered during the analysis:

- **Total Quantity Sold:** Total units recorded in transaction data.
- **Total Quantity Returned:** Total units recorded in return data.
- **Transaction Records Count:** Number of transaction rows.
- **Average Quantity:** Average quantity recorded per transaction row.
- **Sales by Product:** Product performance based on quantities sold.
- **Sales by Store:** Sales quantity across different stores.
- **Sales by Region:** Sales distribution across regions.
- **Sales Over Time:** Changes in sales activity across different periods.
- **Return Rate:** Returned quantity compared with sold quantity.

**Note:** The Transactions table contains quantity information but does not include a direct sales amount or transaction ID. Revenue, profit, and average order value should only be calculated if the required data is available and the calculation assumptions are documented.

## 7. Business Questions

The project will investigate the following questions:

### Sales Performance
- How does sales activity change over time?
- Which periods have the highest sales quantities?
- Which stores and regions have the highest sales quantities?

### Product Performance
- Which products have the highest quantities sold?
- Which product categories perform best?
- How do product prices and costs vary across categories?

### Customer Analysis
- How are customers distributed across different countries?
- What are the main customer demographic characteristics?
- Do purchasing patterns differ across customer groups?

### Returns Analysis
- Which products have the highest return quantities?
- Which stores record the highest return quantities?
- How do returned quantities compare with sold quantities?

These questions may be refined during the analysis phase based on the available data.

## 8. Project Scope and Limitations

### In Scope

- Data exploration and understanding.
- Data cleaning and preparation using Python and Pandas.
- Data Warehouse design and implementation using SQL Server.
- SQL-based business analysis.
- Power BI data modeling and dashboard development.
- Documentation of findings and recommendations.

### Limitations

- The analysis is limited to the available datasets and their time period.
- The Transactions table does not contain a transaction ID or direct sales amount.
- The Returns table does not contain a customer ID, so returns cannot be directly analyzed by customer.
- Some business metrics may require additional assumptions or calculations.
- The results represent the provided dataset and should not be treated as verified current performance of a real retailer.

## 9. Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data exploration, cleaning, and preparation. |
| Pandas | Data manipulation and transformation. |
| NumPy | Numerical operations. |
| Matplotlib | Data visualization. |
| Seaborn | Statistical data visualization. |
| SQL Server | Data Warehouse storage and SQL analysis. |
| Power BI | Data modeling, DAX, and dashboard development. |
| Git & GitHub | Version control and project publishing. |

## 10. Expected Deliverables

The expected project deliverables include:

- Cleaned datasets.
- Data Dictionary.
- SQL Server Data Warehouse.
- SQL analysis queries.
- Interactive Power BI dashboard.
- Business insights and recommendations.
- Complete project documentation.

## 11. Project Success Criteria

The project will be considered successful when:

- All datasets are properly cleaned and validated.
- Data quality issues and transformation decisions are documented.
- The Data Warehouse follows a consistent dimensional model.
- SQL queries provide accurate and meaningful analytical results.
- The Power BI dashboard presents the main business metrics clearly.
- Final insights and recommendations are supported by the available data.