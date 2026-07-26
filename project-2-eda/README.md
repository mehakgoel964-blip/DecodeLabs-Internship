# Project 2: Exploratory Data Analysis (EDA)
### E-Commerce Order Data — DecodeLabs Data Analytics Internship

**Dataset:** `Cleaned Data` sheet, 1,200 orders, Jan 2023 – Jun 2025 (output of Project 1's cleaning stage)

---

## 1. Problem Statement

The business wants to understand how orders behave: what's a typical order worth, which
products and channels drive revenue, whether unusually large orders are errors or real sales,
and whether any variables move together in ways that matter for forecasting or strategy.

## 2. Methodology

- Loaded the pre-cleaned dataset (0 missing values, 0 duplicate rows, 0 TotalPrice math
  mismatches — confirmed by Project 1's own Change Log).
- Computed descriptive statistics (mean, median, five-number summary) for all numeric fields.
- Flagged outliers two ways: the **IQR rule** (Q1/Q3 ± 1.5×IQR — robust to messy data) and the
  **Z-score rule** (|Z| > 3 — better suited to roughly normal data), then classified any flagged
  points as noise or signal.
- Ran a Pearson correlation matrix across `Quantity`, `UnitPrice`, `ItemsInCart`, `TotalPrice`.
- Broke revenue and order counts down by `Product`, `OrderStatus`, `PaymentMethod`,
  `ReferralSource`, and `CouponCode`, and by month, to check for trends.

## 3. Key Findings

### Descriptive statistics

| Metric | Quantity | Unit Price | Items in Cart | Total Price |
|---|---|---|---|---|
| Mean | 2.95 | $356.41 | 5.49 | $1,053.97 |
| Median | 3.00 | $364.21 | 5.00 | $823.62 |
| Min | 1 | $11.39 | 1 | $11.39 |
| Q1 | 2 | $186.06 | 4 | $410.52 |
| Q3 | 4 | $521.57 | 7 | $1,578.48 |
| Max | 5 | $699.93 | 10 | $3,456.40 |

`TotalPrice`'s mean ($1,054) sits well above its median ($824) — the distribution is
**right-skewed**. That gap is a clue that a handful of large orders pull the average up, which
the outlier check below confirms.

![Distribution of order value](charts/01_totalprice_distribution.png)

### Outliers: mostly signal, not noise

| Column | IQR outliers | Z-score outliers (\|Z\|>3) |
|---|---|---|
| Quantity | 0 | 0 |
| UnitPrice | 0 | 0 |
| ItemsInCart | 0 | 0 |
| TotalPrice | **8** | 0 |

The Z-score test finds nothing extreme — no order is a statistical freak relative to the whole
distribution's spread. The IQR test flags 8 orders above **$3,330**. Inspecting them shows every
one is a legitimate **Quantity = 5 × high-UnitPrice** combination (e.g. 5 laptops or 5 tablets at
~$670–$700 each), spread across different products and order statuses. This is **signal, not
noise**: real large-basket purchases, not data-entry errors — no cleanup needed, but worth
watching as a "big order" segment.

![Boxplot of order value by product](charts/02_boxplot_by_product.png)

### Correlation: order size builds total value, but from two separate levers

| | Quantity | UnitPrice | ItemsInCart | TotalPrice |
|---|---|---|---|---|
| Quantity | 1.00 | 0.01 | 0.65 | 0.62 |
| UnitPrice | 0.01 | 1.00 | 0.00 | **0.72** |
| ItemsInCart | 0.65 | 0.00 | 1.00 | 0.39 |
| TotalPrice | 0.62 | 0.72 | 0.39 | 1.00 |

- `UnitPrice` correlates most strongly with `TotalPrice` (r = 0.72), followed by `Quantity`
  (r = 0.62) — both matter, with price being slightly more influential.
- `Quantity` and `UnitPrice` are essentially uncorrelated (r = 0.01), meaning customers aren't
  systematically buying more units *because* items are cheap (or vice versa) — the two levers
  move independently, which is expected for this catalog.
- `ItemsInCart` correlates with `Quantity` (r = 0.65) but only moderately with `TotalPrice`
  (r = 0.39) — cart size is a weaker revenue predictor than either quantity or price alone.

![Correlation heatmap](charts/03_correlation_heatmap.png)

### Segment breakdown: revenue is broad-based, not concentrated

| Product | Orders | Avg Order Value | Revenue |
|---|---|---|---|
| Chair | 178 | $1,099 | $195,620 |
| Printer | 181 | $1,081 | $195,613 |
| Laptop | 173 | $1,111 | $192,127 |
| Tablet | 179 | $1,042 | $186,569 |
| Monitor | 163 | $1,078 | $175,651 |
| Desk | 170 | $985 | $167,460 |
| Phone | 156 | $973 | $151,722 |

No single product dominates — revenue is spread fairly evenly across the 7-item catalog (a
~1.29x gap between the top and bottom performer). Payment method, referral source, and coupon
code show similarly even splits, suggesting none of these channels is currently a standout
growth lever or a liability on its own.

![Revenue by product](charts/04_revenue_by_product.png)

### Order status: cancellations are the single largest bucket

| Status | Orders | Share |
|---|---|---|
| Cancelled | 250 | 20.8% |
| Pending | 237 | 19.8% |
| Returned | 247 | 20.6% |
| Shipped | 235 | 19.6% |
| Delivered | 231 | 19.3% |

**Cancelled + Returned together account for 41.4% of all orders** — meaning fewer than 6 in 10
orders placed actually complete as delivered or shipped-and-kept. Cancelled orders also carry the
*highest* average value ($1,106) of any status, so the revenue at risk from cancellations is
disproportionately large, not evenly spread.

![Order status breakdown](charts/06_order_status.png)

### Trend over time: revenue softening year over year

| Year | Orders | Revenue | Avg Order Value |
|---|---|---|---|
| 2023 | 510 | $552,643 | $1,084 |
| 2024 | 459 | $480,236 | $1,046 |
| 2025* | 231 | $231,883 | $1,004 |

*2025 covers only Jan–Jun (partial year), so its total isn't directly comparable to the full
years — but its average order value is included for a fair, like-for-like comparison.*

Average order value has declined each year (\$1,084 → \$1,046 → \$1,004), and monthly order
counts show no clear seasonal spike — the business isn't riding a growth curve on either volume
or order size.

![Monthly revenue trend](charts/05_monthly_trend.png)

## 4. Recommendations

1. **Investigate the cancellation rate.** At 20.8% — the single largest status bucket, and the
   one with the highest average order value — even a modest reduction (e.g. 5 points) would
   recover meaningful revenue. Since this dataset alone doesn't include reasons for cancellation,
   pair this finding with checkout, payment, or fulfillment logs next.
2. **Treat the 8 large orders as a segment, not an error.** They're legitimate high-quantity,
   high-price purchases; consider whether a "bulk buyer" outreach or discount tier make sense.
3. **Don't rely on Quantity and UnitPrice interchangeably** — they drive TotalPrice independently
   (r ≈ 0.01 with each other), so a pricing strategy and a basket-size strategy need to be
   designed separately rather than assuming one moves the other.
4. **Watch the declining average order value** across three years; combined with flat-to-soft
   order counts, this points to softening revenue per customer that's worth a deeper channel- or
   customer-level look in a follow-up project.

---
*Analysis code: `eda_analysis.py`. Charts: `/charts`. Prepared as part of DecodeLabs Data
Analytics Internship — Project 2 (Exploratory Data Analysis).*
