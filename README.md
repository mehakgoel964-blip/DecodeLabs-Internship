# Project 4: Data Visualization (Optional)

**Goal:** Turn the same order dataset used in Projects 1–3 into a boardroom-ready visual
narrative — not just "making pretty charts," but data storytelling: choosing the right chart
for each question, stripping out chartjunk, and driving toward a specific executive decision.

## Deliverable

- **`Project4_Order_Diagnostics.pptx`** — a 7-slide presentation deck built with native,
  editable PowerPoint charts (not images).

## Structure (SCR framework: Situation → Complication → Resolution)

| Slide | Type | Insight |
|---|---|---|
| 1 | Title | Order Diagnostics — Turning a Silent Revenue Leak Into an Executive Action Plan |
| 2 | Line chart (Situation) | Quarterly revenue has been sliding since early 2023, with no stable floor |
| 3 | Bar chart (Complication) | Cancelled orders carry the highest average value of any status — $1,105.58 |
| 4 | Stacked bar (Complication) | Cancellations dipped in 2024, then spiked to 26% of all orders in 2025 |
| 5 | Scatter plot (Why it matters) | Unit price drives order value more than quantity does (r = 0.72 vs 0.62) |
| 6 | Bar chart (Resolution) | Instagram and Facebook cancellations cost the most per order — target them first |
| 7 | Closing / KPI summary | Recommended next steps, sized for the "5-second rule" |

## Design principles applied

- **Chart Selection Matrix** — bar for category comparisons, line for trend over time, scatter
  for relationships, stacked bar for composition. No pie charts.
- **Color as a spotlight, not decoration** — muted grey for context, one bold accent color
  reserved exclusively for the data point that matters (e.g. the Cancelled bar, the 2025 spike).
- **Axis integrity** — every bar chart starts at zero; no 3D effects.
- **Action titles** — each title states the conclusion, not just the topic.
- **One slide, one message** — no crowded pages; each chart answers exactly one business
  question.
- **5-second rule** — the closing slide leads with KPIs top-left and ends on a concrete
  "what should we do next."

This project ties directly back to the same cancellation finding surfaced independently in
Project 2 (EDA) and Project 3 (SQL) — giving the whole portfolio one consistent, evidence-backed
story across four different tools and techniques.
