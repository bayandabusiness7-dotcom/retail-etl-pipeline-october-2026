# Retail Sales Data Warehouse — Medallion Architecture (SQL Server)

A data warehouse built on SQL Server using the Medallion Architecture (Bronze → Silver → Gold), with SSIS for ingestion and T-SQL for transformations.

## 🏗️ Architecture

```
 CSV source  ──SSIS──►  retail_stg.bronze  ──T-SQL──►  retail_dwh.silver  ──T-SQL──►  retail_dwh.gold  ──►  Reporting
                        (raw, as-is)                   (clean, typed)                 (facts & dims)
```

| Layer  | Database     | Schema   | Purpose                                                          |
|--------|--------------|----------|------------------------------------------------------------------|
| Bronze | `retail_stg` | `bronze` | Raw data loaded exactly as received. All columns `VARCHAR(50)`.  |
| Silver | `retail_dwh` | `silver` | Cleaned, deduplicated, correctly typed and standardised data.    |
| Gold   | `retail_dwh` | `gold`   | Business-ready star schema (fact and dimension views).           |

## 📁 Repository Structure

```
├── datasets/
│   └── retail_sales_dataset.csv     # Source data
├── scripts/
│   ├── create_retail_db.sql         # Creates databases, schemas and bronze table
│   ├── bronze/                      # SSIS packages / bulk load scripts
│   ├── silver/                      # Cleaning and transformation scripts
│   └── gold/                        # Fact and dimension views
└── README.md
```

## 📊 Source Dataset

**`bronze.retail_sales_raw`**

| Column           | Bronze Type   | Target Silver Type |
|------------------|---------------|--------------------|
| Transaction ID   | `VARCHAR(50)` | `INT`              |
| Date             | `VARCHAR(50)` | `DATE`             |
| Customer ID      | `VARCHAR(50)` | `VARCHAR(20)`      |
| Gender           | `VARCHAR(50)` | `VARCHAR(10)`      |
| Age              | `VARCHAR(50)` | `INT`              |
| Product Category | `VARCHAR(50)` | `VARCHAR(50)`      |
| Quantity         | `VARCHAR(50)` | `INT`              |
| Price per Unit   | `VARCHAR(50)` | `DECIMAL(10,2)`    |
| Total Amount     | `VARCHAR(50)` | `DECIMAL(10,2)`    |

Bronze stores everything as text so that bad rows land in the table instead of failing the load. All type casting happens in Silver.

## 🚀 Getting Started

### Prerequisites

- SQL Server (Developer or Express edition)
- SQL Server Management Studio (SSMS)
- Visual Studio with the SQL Server Integration Services Projects extension

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   ```
2. **Create the databases, schemas and tables.** Open `scripts/create_retail_db.sql` in SSMS and run it with `F5`. The script is safe to rerun: it only creates objects that don't already exist.
3. **Load Bronze.** Run the SSIS package, which uses a Flat File Source feeding an OLE DB Destination at `[bronze].[retail_sales_raw]`.
4. **Verify the load**
   ```sql
   SELECT COUNT(*) FROM retail_stg.bronze.retail_sales_raw;
   ```

## 🛣️ Roadmap

- [x] Create databases and schemas
- [x] Create bronze table
- [ ] Load raw CSV into bronze via SSIS
- [ ] Silver: cleaning, casting and deduplication
- [ ] Gold: `fact_sales`, `dim_customer`, `dim_product`, `dim_date`
- [ ] Data quality checks
- [ ] Reporting layer

## 🛠️ Tech Stack

- SQL Server
- SQL Server Integration Services (SSIS)
- T-SQL
- SQL Server Management Studio (SSMS)
- Visual Studio
