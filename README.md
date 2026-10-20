# Retail Database Setup

SQL Server script that creates the staging and warehouse databases, their schemas, and the raw landing table for the retail sales data.

## Files

| File | Purpose |
|------|---------|
| `create_retail_db.sql` | Creates databases, schemas and the raw table |

## What the script creates

### Databases

| Database | Purpose |
|----------|---------|
| `retail_stg` | Staging database where raw data lands |
| `retail_dwh` | Data warehouse for cleaned and modelled data |

### Schemas

| Database | Schema | Layer |
|----------|--------|-------|
| `retail_stg` | `bronze` | Raw data, loaded as is from the source file |
| `retail_dwh` | `silver` | Cleaned and standardised data |
| `retail_dwh` | `gold` | Business-ready data for reporting |

### Tables

`bronze.retail_sales_raw` in `retail_stg`. All columns are `VARCHAR(50)` so the flat file loads without type errors.

| Column | Type |
|--------|------|
| Transaction ID | VARCHAR(50) |
| Date | VARCHAR(50) |
| Customer ID | VARCHAR(50) |
| Gender | VARCHAR(50) |
| Age | VARCHAR(50) |
| Product Category | VARCHAR(50) |
| Quantity | VARCHAR(50) |
| Price per Unit | VARCHAR(50) |
| Total Amount | VARCHAR(50) |

## How to run

1. Open SQL Server Management Studio (SSMS) and connect to your instance.
2. Open `create_retail_db.sql` (**File > Open > File**).
3. Press **F5** to execute.
4. Check the results of the verify queries at the end of the script.

The script is safe to re-run. Every step checks whether the object already exists before creating it.

## Loading data

The raw table is designed to be the destination for an SSIS package:

1. In Visual Studio, create a Flat File Source pointing to the retail sales CSV.
2. Add an OLE DB Destination using a connection manager to `retail_stg` on `localhost`.
3. Map the source columns to `bronze.retail_sales_raw`.
4. Run the package.

## Next steps

- Build silver tables in `retail_dwh` that convert the text columns to proper data types (dates, integers, decimals).
- Build gold tables or views for reporting.
