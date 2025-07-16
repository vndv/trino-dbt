# DBT Project

DBT project for transforming API data into data marts.

## Setup

1. Create virtual environment:
```bash
uv venv
source .venv/bin/activate  # for Linux/MacOS
uv sync
```

2. Configure dbt profile in `~/.dbt/profiles.yml`:
```yaml
jaffle_shop:
  target: dev
  outputs:
    dev:
      type: trino
      method: none
      user: trino
      host: localhost
      port: 8080
      database: iceberg
      schema: api_data
      threads: 4
```

## Project Structure
```
jaffle_shop/
├── models/
│   ├── staging/          # Initial transformations
│   ├── intermediate/     # Intermediate tables
│   └── marts/           # Data marts
├── macros/              # Reusable macros
├── tests/               # Data tests
└── dbt_project.yml      # Project configuration
```

## Usage

```bash
# Run all models
dbt run

# Run tests
dbt test

# Generate documentation
dbt docs generate
dbt docs serve
```