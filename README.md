# Example project for work with Trino, Iceberg and DBT

This project demonstrates working with Trino, Apache Iceberg, and DBT to build a modern data stack.

## Architecture
- MinIO (S3-compatible storage) - data storage
- Trino - SQL query engine
- Apache Iceberg - table format
- Hive Metastore - table metadata
- DBT - data transformation
- Python scripts for API data ingestion

## Prerequisites
- Docker and docker-compose
- Python 3.11+
- [uv](https://github.com/astral-sh/uv) - modern Python package manager
- [DBeaver](https://dbeaver.io/) or other SQL client (optional)

## Setup and Run

### 1. Environment Setup
```bash
# Clone repository
git clone <repo-url>
cd <repo-name>

# Start infrastructure
docker-compose up -d

# Check services status
docker-compose ps
```

### 2. Python Environment Setup for Data Ingestion
```bash
cd app
uv venv
source .venv/bin/activate  # for Linux/MacOS
# or .venv\Scripts\activate for Windows
uv sync
```

### 3. Python Environment Setup for DBT
```bash
cd dbt
uv venv
source .venv/bin/activate  # for Linux/MacOS
# or .venv\Scripts\activate for Windows
uv sync
```

### 4. Create Schema in Trino
Connect to Trino via DBeaver or execute SQL via CLI:
```sql
create schema iceberg.api_data;
```

Trino connection parameters:
- Host: localhost
- Port: 8080
- Catalog: iceberg
- Schema: api_data
- User: trino
- Password: not required

## Usage

### Load Data from API
```bash
cd app
source .venv/bin/activate
python load.py
```

### Run DBT Transformations
```bash
cd dbt
source .venv/bin/activate
dbt run
```

## Project Structure
```
.
├── app/                    # Python scripts for data ingestion
│   ├── catalog.py         # Iceberg catalog configuration
│   ├── load.py           # Main ingestion script
│   ├── rest_adapter.py   # API adapter
│   └── settings.py       # Application settings
├── dbt/                   # DBT project
│   └── jaffle_shop/      # Models and transformations
├── trino-etc/            # Trino configuration
│   ├── catalog/          # Catalog settings
│   └── config.properties # Main settings
└── docker-compose.yml    # Infrastructure description
```

## Useful Commands
```bash
# View service logs
docker-compose logs -f trino
docker-compose logs -f minio
docker-compose logs -f hive-metastore

# Restart service
docker-compose restart trino

# Stop all services
docker-compose down
```
