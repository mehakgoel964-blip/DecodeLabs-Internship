# DecodeLabs Data Analytics Internship — Batch 2026

Portfolio of projects completed as part of the DecodeLabs Industrial Training Kit
(Data Analytics track, Batch 2026). Each project builds on the last, using the same
1,200-row e-commerce order dataset throughout — from raw cleaning, to exploratory analysis,
to SQL-based querying.

## Projects

| # | Project | Focus | Link |
|---|---|---|---|
| 1 | Data Cleaning | Producing an analysis-ready dataset from raw order data | [`project-1-data-cleaning/`](./project-1-data-cleaning) |
| 2 | Exploratory Data Analysis (EDA) | Descriptive statistics, outlier detection, correlation analysis, trend identification | [`project-2-eda/`](./project-2-eda) |
| 3 | SQL Data Analysis | Querying the same dataset in MySQL — filtering, grouping, aggregating, and answering business questions | [`project-3-sql-analysis/`](./project-3-sql-analysis) |

## Tech Stack

- **Python** (pandas, matplotlib) — data cleaning and EDA
- **MySQL 8.0** — structured querying and aggregation
- **HTML/JS (Chart.js)** — interactive dashboard for EDA findings

## Key Findings Across the Projects

- Order value is right-skewed — a handful of large, legitimate bulk orders (not data errors)
  pull the average above the median.
- **Cancelled orders are both the most frequent status (20.8%) and the highest-value on
  average** ($1,105.58) — confirmed independently through both the EDA (Project 2) and SQL
  queries (Project 3), making it the strongest, most actionable finding in this portfolio.
- Revenue is evenly spread across the 7-product catalog (12–15.5% share each) — no single
  product is propping up or dragging down the business.
- Average order value has declined every year from 2023 to 2025, worth a follow-up
  investigation into customer-level or channel-level causes.

Each project folder has its own README with full methodology, queries/code, and detailed
findings.
