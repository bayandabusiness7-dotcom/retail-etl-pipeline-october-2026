/* ============================================
   1. CREATE DATABASES
   ============================================ */
USE master;
GO

IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = N'retail_stg')
BEGIN
    CREATE DATABASE retail_stg;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = N'retail_dwh')
BEGIN
    CREATE DATABASE retail_dwh;
END
GO


/* ============================================
   2. CREATE SCHEMAS
   ============================================ */

-- Staging: bronze
USE retail_stg;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

-- Warehouse: silver and gold
USE retail_dwh;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'silver')
    EXEC('CREATE SCHEMA silver');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'gold')
    EXEC('CREATE SCHEMA gold');
GO


/* ============================================
   3. CREATE TABLE (raw landing table)
   ============================================ */
USE retail_stg;
GO

IF OBJECT_ID(N'bronze.retail_sales_raw', N'U') IS NULL
BEGIN
    CREATE TABLE bronze.retail_sales_raw
    (
        [Transaction ID]    VARCHAR(50),
        [Date]              VARCHAR(50),
        [Customer ID]       VARCHAR(50),
        [Gender]            VARCHAR(50),
        [Age]               VARCHAR(50),
        [Product Category]  VARCHAR(50),
        [Quantity]          VARCHAR(50),
        [Price per Unit]    VARCHAR(50),
        [Total Amount]      VARCHAR(50)
    );
END
GO


/* ============================================
   4. VERIFY
   ============================================ */
SELECT name, create_date
FROM sys.databases
WHERE name IN (N'retail_stg', N'retail_dwh');

SELECT s.name AS schema_name
FROM retail_stg.sys.schemas s
WHERE s.name = N'bronze';

SELECT s.name AS schema_name
FROM retail_dwh.sys.schemas s
WHERE s.name IN (N'silver', N'gold');

SELECT TABLE_SCHEMA, TABLE_NAME
FROM retail_stg.INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = N'bronze';
