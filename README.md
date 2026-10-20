Retail Sales Data Warehouse — Medallion Architecture (SQL Server)
A data warehouse built on SQL Server using the Medallion Architecture (Bronze → Silver → Gold), with SSIS for ingestion and T-SQL for transformations.

🏗️ Architecture
 CSV source  ──SSIS──►  stg_Db.bronze  ──T-SQL──►  dwh_db.silver  ──T-SQL──►  dwh_db.gold  ──►  Reporting
                        (raw, as-is)               (clean, typed)             (facts & dims)
Layer	Database	Schema	Purpose
Bronze	stg_Db	bronze	Raw data loaded exactly as received. All columns VARCHAR(50).
Silver	dwh_db	silver	Cleaned, deduplicated, correctly typed and standardised data.
Gold	dwh_db	gold	Business-ready star schema (fact and dimension views).
📁 Repository Structure
├── datasets/
│   └── retail_sales_dataset.csv     # Source data
├── scripts/
│   ├── init_database.sql            # Creates databases, schemas and bronze tables
│   ├── bronze/                      # SSIS packages / bulk load scripts
│   ├── silver/                      # Cleaning and transformation scripts
│   └── gold/                        # Fact and dimension views
└── README.md
📊 Source Dataset
bronze.retail_sales_dataset

Column	Bronze Type	Target Silver Type
Transaction ID	VARCHAR(50)	INT
Date	VARCHAR(50)	DATE
Customer ID	VARCHAR(50)	VARCHAR(20)
Gender	VARCHAR(50)	VARCHAR(10)
Age	VARCHAR(50)	INT
Product Category	VARCHAR(50)	VARCHAR(50)
Quantity	VARCHAR(50)	INT
Price per Unit	VARCHAR(50)	DECIMAL(10,2)
Total Amount	VARCHAR(50)	DECIMAL(10,2)
Bronze stores everything as text so that bad rows land in the table instead of failing the load. All type casting happens in Silver.

🚀 Getting Started
Prerequisites
SQL Server (Developer or Express edition)
SQL Server Management Studio (SSMS)
Visual Studio with the SQL Server Integration Services Projects extension
Setup
Clone the repo
git clone https://github.com/<your-username>/<repo-name>.git
Create the databases, schemas and tables. Open scripts/init_database.sql in SSMS and run it with F5. The script is safe to rerun: it only creates objects that don't already exist.
Load Bronze. Run the SSIS package, which uses a Flat File Source feeding an OLE DB Destination at [bronze].[retail_sales_dataset].
Verify the load
SELECT COUNT(*) FROM stg_Db.bronze.retail_sales_dataset;
🛣️ Roadmap
 Create databases and schemas
 Create bronze table
 Load raw CSV into bronze via SSIS
 Silver: cleaning, casting and deduplication
 Gold: fact_sales, dim_customer, dim_product, dim_date
 Data quality checks
 Reporting layer
🛠️ Tech Stack
