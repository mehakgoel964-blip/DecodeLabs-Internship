# Project 3: SQL Data Analysis
### E-Commerce Order Data — DecodeLabs Data Analytics Internship

**Dataset:** `orders` table, 1,200 rows (same cleaned order data used in Project 2), loaded
into a **MySQL 8.0** database (`decodelabs_ecommerce`). All 23 queries below were executed for
real against that live MySQL instance — every result shown is actual query output, not
illustrative. (Cross-validated against an earlier SQLite run of the same queries — results
matched exactly, confirming the analysis is correct independent of engine.)

---

## 1. Problem Statement

Move from viewing spreadsheets to **querying for truth**: use SQL's declarative logic
(SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY execution order) to filter, group,
and aggregate raw order data into business-ready answers.

## 2. Methodology

- Loaded the same 1,200-row cleaned order dataset from Project 2 into SQLite (`orders.db`).
- Wrote queries in increasing complexity: basic `SELECT` → `WHERE` filters → `ORDER BY` →
  `GROUP BY` with aggregations (`COUNT`, `SUM`, `AVG`) → `HAVING` on aggregated groups →
  percentage-of-total calculations via subqueries → a combined multi-clause business query.
- Respected SQL's **logical execution order** (`FROM/JOIN → WHERE → GROUP BY → HAVING →
  SELECT → ORDER BY`) rather than its written top-to-bottom order — e.g. `ORDER BY Revenue`
  in query 3.3 only works because `SELECT` (which creates the `Revenue` alias) runs before
  `ORDER BY` does, even though it's written above it.

## 3. Key Findings by Section

### Section 2 — WHERE (row-level filtering)

| Query | Result |
|---|---|
| All Cancelled orders | **250 rows** returned |
| Orders above $2,000 | **180 rows** — the top one is a $3,456.40 Tablet order (Qty 5 × $691.28) |
| Orders using a real coupon (`SAVE10`/`WINTER15`, not "No Coupon") | **578 rows** (48.2% of all orders) |
| Cancelled + Credit Card + > $1,000 | **26 rows** — top is $3,267.35 |
| Orders between $500–$1,500 | **495 rows** (41.3%) — confirms most orders cluster in the middle, consistent with the right-skew seen in Project 2 |

### Section 4 — GROUP BY + Aggregations

**Revenue by product** (COUNT, SUM, AVG in one query):

| Product | Orders | Revenue | Avg Order Value |
|---|---|---|---|
| Chair | 178 | $195,620.11 | $1,098.99 |
| Printer | 181 | $195,612.61 | $1,080.73 |
| Laptop | 173 | $192,126.56 | $1,110.56 |
| Tablet | 179 | $186,568.95 | $1,042.28 |
| Monitor | 163 | $175,651.41 | $1,077.62 |
| Desk | 170 | $167,459.93 | $985.06 |
| Phone | 156 | $151,722.39 | $972.58 |

**Revenue by order status** — confirms the Project 2 finding directly from SQL:

| Status | Orders | Avg Order Value | Revenue |
|---|---|---|---|
| Cancelled | 250 | **$1,105.58** (highest) | $276,396.21 |
| Pending | 237 | $1,081.55 | $256,328.15 |
| Shipped | 235 | $1,047.49 | $246,159.58 |
| Delivered | 231 | $1,050.22 | $242,600.32 |
| Returned | 247 | $984.93 (lowest) | $243,277.70 |

**Yearly trend** — average order value declining every year, confirmed directly from SQL:

| Year | Orders | Avg Order Value | Revenue |
|---|---|---|---|
| 2023 | 510 | $1,083.61 | $552,643.24 |
| 2024 | 459 | $1,046.27 | $480,235.87 |
| 2025* | 231 | $1,003.82 | $231,882.85 |

*2025 is a partial year (Jan–Jun).*

### Section 5 — HAVING (filtering aggregated groups)

- Products with **more than 170 orders**: Printer (181), Tablet (179), Chair (178), Laptop (173) — `WHERE` can't do this because `COUNT(*)` doesn't exist until after grouping; `HAVING` is required.
- Referral sources generating **over $170,000**: all 5 sources qualify (Instagram leads at $275,285.45).
- Order statuses with **average order value above the $1,054 overall mean**: only **Cancelled** ($1,105.58) and **Pending** ($1,081.55) clear that bar — reinforcing that cancelled orders aren't just numerous, they're disproportionately large.

### Section 6 — Percentage Contribution (subquery pattern)

| Product | Revenue | % of Total Revenue |
|---|---|---|
| Printer | $195,612.61 | 15.47% |
| Chair | $195,620.11 | 15.47% |
| Laptop | $192,126.56 | 15.19% |
| Tablet | $186,568.95 | 14.75% |
| Monitor | $175,651.41 | 13.89% |
| Desk | $167,459.93 | 13.24% |
| Phone | $151,722.39 | 12.00% |

| Order Status | Orders | % of All Orders |
|---|---|---|
| Cancelled | 250 | **20.8%** |
| Returned | 247 | 20.6% |
| Pending | 237 | 19.8% |
| Shipped | 235 | 19.6% |
| Delivered | 231 | 19.3% |

### Section 7 — Combined business query

**"Which referral sources drive the most cancelled revenue?"** — combining `WHERE` +
`GROUP BY` + `HAVING` + `ORDER BY` in one query:

| Referral Source | Cancelled Orders | Cancelled Revenue | Avg Cancelled Order Value |
|---|---|---|---|
| Email | 59 | $60,266.49 | $1,021.47 |
| Google | 58 | $57,582.70 | $992.81 |
| Referral | 50 | $56,945.21 | $1,138.90 |
| Facebook | 42 | $50,935.74 | $1,212.76 |
| Instagram | 41 | $50,666.07 | $1,235.76 |

Email brings in the most cancelled orders by count, but **Instagram and Facebook cancellations
are the most expensive per order** ($1,235.76 and $1,212.76 avg) — worth flagging separately
from a pure volume view.

## 4. Recommendations

1. **Cancellations aren't just frequent — they're the highest-value segment.** Both the
   `HAVING`-filtered average (Section 5) and the raw breakdown (Section 4) agree: Cancelled
   orders average $1,105.58, above every other status. Confirms the Project 2 EDA finding with
   independent SQL evidence.
2. **Investigate cancellations from Instagram/Facebook specifically** — fewer cancelled orders
   than Email, but the highest dollar value per cancelled order, meaning a fix there recovers
   more revenue per order addressed.
3. **Product revenue is genuinely balanced** (12.0%–15.5% share each) — no single SKU is
   propping up the business or dragging it down; this rules out a "kill the underperformer"
   strategy as a priority.
4. **48% of orders already use a coupon** — worth checking whether coupon usage correlates with
   cancellation before running further promotions.

---
*Query file: `queries_mysql.sql`. Database dump: `orders_mysql_dump.sql` (MySQL 8.0, import with
`mysql -u root -p your_db < orders_mysql_dump.sql`). All results generated by executing the
queries directly against a live MySQL instance — see `results_mysql.json` for raw output.
Prepared as part of DecodeLabs Data Analytics Internship — Project 3 (SQL Data Analysis).*
