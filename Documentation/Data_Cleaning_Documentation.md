# Data Cleaning & Preparation
## Maven Market — Notebook Documentation

**Notebook:** `02_Data_Cleaning.ipynb`  
**Project:** Maven Market End-to-End Data Analysis  
**Tools:** Python, Pandas, NumPy

---

## 1. Objective

This notebook prepares the Maven Market source data for database storage and further analysis. The CSV files are loaded, combined where necessary, copied into working DataFrames, checked, cleaned, and exported as processed CSV files.

The original source files are kept unchanged. All cleaning operations are performed on separate working copies.

## 2. Source Data

The project contains seven logical tables:

| Table | Description |
|---|---|
| Calendar | Date records used for time-based analysis |
| Customers | Customer details and demographic attributes |
| Products | Product information and attributes |
| Regions | Sales region and district information |
| Returns | Product return records |
| Stores | Store details and location information |
| Transactions | Sales transaction records |

The transaction data was provided in two separate files: `Transactions_1997` and `Transactions_1998`. These files were combined into one DataFrame:

```python
transactions = pd.concat(
    [transactions_1997, transactions_1998],
    ignore_index=True
)
```

`ignore_index=True` creates a new continuous index for the combined DataFrame.

## 3. Loading the Data

The source CSV files were loaded from the project's `Data/Row Data` directory using Pandas. `Path` was used to manage file and directory paths.

## 4. Creating Working Copies

Separate copies were created before applying cleaning operations:

```python
calendar_clean = calendar.copy()
customers_clean = customers.copy()
products_clean = products.copy()
regions_clean = regions.copy()
returns_clean = returns.copy()
stores_clean = stores.copy()
transactions_clean = transactions.copy()
```

This protects the original DataFrames from accidental modification.

The cleaned DataFrames were organized in a dictionary named `tables`:

```python
tables = {
    "Calendar": calendar_clean,
    "Customers": customers_clean,
    "Products": products_clean,
    "Regions": regions_clean,
    "Returns": returns_clean,
    "Stores": stores_clean,
    "Transactions": transactions_clean
}
```

## 5. Initial Validation

The dimensions of the working DataFrames were checked against the results recorded during Data Exploration.

| Table | Rows | Columns |
|---|---:|---:|
| Calendar | 730 | 1 |
| Customers | 10,281 | 20 |
| Products | 1,560 | 9 |
| Regions | 109 | 3 |
| Returns | 7,087 | 4 |
| Stores | 24 | 13 |
| Transactions | 269,720 | 6 |

The two transaction files produced a combined table containing **269,720 rows**.

## 6. Data Type Standardization

### 6.1 Date Columns

Date columns were converted from strings to Pandas datetime types using `pd.to_datetime()` with `errors="coerce"`. Invalid values would be converted to `NaT`, making them easier to identify during validation.

| Table | Columns converted |
|---|---|
| Calendar | `date` |
| Customers | `birthdate`, `acct_open_date` |
| Returns | `return_date` |
| Stores | `first_opened_date`, `last_remodel_date` |
| Transactions | `transaction_date`, `stock_date` |

After conversion, the date columns were checked for newly generated `NaT` values. No conversion failures were found.

### 6.2 Identifier Columns

Some numeric-looking columns represent identifiers rather than quantities. They were converted to string types.

| Table | Column | Reason |
|---|---|---|
| Customers | `customer_postal_code` | Postal codes are identifiers, not numeric measures |
| Products | `product_sku` | SKU is a product identifier |

## 7. Data Quality Considerations

The exploration phase identified records and missing values that require careful handling:

- **Transactions:** 9 exact duplicate pairs were identified in the combined transaction data.
- **Returns:** 5 exact duplicate pairs were identified in the returns data.
- These potential duplicates were not automatically deleted because identical records may represent legitimate repeated business events. They should be investigated before deciding whether they are errors.
- Product attributes such as `recyclable` and `low_fat` contain missing values. These were not automatically replaced with zero because the available data does not establish that a missing value means `False`.
- The `last_name` column in Customers contains a missing value. No value was invented to fill it.

These decisions help avoid introducing unsupported assumptions into the dataset.

## 8. Exporting Processed Data

The cleaned DataFrames were exported as CSV files to:

`Data/Processed`

These files will be used in the next stages, including SQL Server loading and data warehouse development. The original files in `Data/Row Data` remain unchanged.

## 9. Outcome

The notebook completed the following preparation tasks:

- Loaded the source CSV files.
- Combined the 1997 and 1998 transaction files.
- Created independent working copies.
- Organized the cleaned DataFrames in a dictionary.
- Validated table dimensions.
- Converted date columns to datetime types.
- Converted selected identifier columns to string types.
- Reviewed potential duplicates and missing values without making unsupported changes.
- Exported the processed tables to `Data/Processed`.

## 10. Next Stage

The next stage is to load the processed data into SQL Server and build the Maven Market data warehouse using a dimensional model.

The planned model contains two fact tables, `FactTransactions` and `FactReturns`, and four dimension tables: `DimCustomer`, `DimProduct`, `DimStore`, and `DimDate`.

The Regions attributes will be incorporated into `DimStore` to keep the model straightforward.
