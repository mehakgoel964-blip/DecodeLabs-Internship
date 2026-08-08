# DecodeLabs Data Analytics Internship — Batch 2026

Portfolio of projects completed as part of the DecodeLabs Industrial Training Kit
(Data Analytics track, Batch 2026). Each project builds on the last, using the same
1,200-row e-commerce order dataset throughout — from raw cleaning, to exploratory analysis,
to SQL-based querying, to executive-ready visualization.

## Projects

| # | Project | Focus | Link |
|---|---|---|---|
| 1 | Data Cleaning | Producing an analysis-ready dataset from raw order data | [`project-1-data-cleaning/`](./project-1-data-cleaning) |
| 2 | Exploratory Data Analysis (EDA) | Descriptive statistics, outlier detection, correlation analysis, trend identification | [`project-2-eda/`](./project-2-eda) |
| 3 | SQL Data Analysis | Querying the same dataset in MySQL — filtering, grouping, aggregating, and answering business questions | [`project-3-sql-analysis/`](./project-3-sql-analysis) |
| 4 | Data Visualization *(optional)* | Turning the findings into a boardroom-ready presentation deck — chart selection, data-ink minimalism, and data storytelling | [`project-4-visualization/`](./project-4-visualization) |

## Tech Stack

- **Python** (pandas, matplotlib) — data cleaning and EDA
- **MySQL 8.0** — structured querying and aggregation
- **HTML/JS (Chart.js)** — interactive dashboard for EDA findings
- **PowerPoint (native charts)** — executive presentation deck for Project 4

## Key Findings Across the Projects

- Order value is right-skewed — a handful of large, legitimate bulk orders (not data errors)
  pull the average above the median.
- **Cancelled orders are both the most frequent status (20.8%) and the highest-value on
  average** ($1,105.58) — confirmed independently through the EDA (Project 2), SQL queries
  (Project 3), *and* the visualization deck (Project 4), making it the strongest, most
  consistently-evidenced finding across this entire portfolio.
- The cancellation rate dipped to 18.1% in 2024, then spiked to 26% in 2025 — a worsening
  trend, not a one-off blip.
- Revenue is evenly spread across the 7-product catalog (12–15.5% share each) — no single
  product is propping up or dragging down the business.
- Average order value has declined every year from 2023 to 2025.
- Unit price is a stronger driver of order value than quantity (r = 0.72 vs 0.62) — cancelled
  orders skew toward higher-unit-price items, which partly explains why they're so costly.
- Instagram and Facebook cancellations cost the most per order ($1,236 and $1,213 avg) even
  though Email has more cancelled orders by count — the clearest actionable lead in the data.

Each project folder has its own README with full methodology, queries/code, and detailed
findings.
