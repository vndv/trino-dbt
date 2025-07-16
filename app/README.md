# Data Ingestion Application

Application for loading data from REST API into Apache Iceberg via Trino.

## Structure
- `catalog.py` - Iceberg catalog configuration and connection
- `load.py` - main data ingestion script
- `rest_adapter.py` - REST API adapter
- `settings.py` - application settings and environment variables
- `iceberg_loader.py` - class for working with Iceberg tables

## Setup
1. Create `.env` file based on example:
```
HIVE_URI=thrift://localhost:9083
S3_ACCESS_KEY=minio
S3_SECRET_KEY=minio123
S3_ENDPOINT=http://localhost:9000
S3_BUCKET=datalake
S3_REGION=us-east-1
```

2. Install dependencies:
```bash
uv venv
source .venv/bin/activate
uv sync
```

## Usage
```bash
python load.py
```

The script will load data from API into the following tables:
- api_data.customers
- api_data.orders
- api_data.items
- api_data.products
- api_data.supplies
- api_data.stores
