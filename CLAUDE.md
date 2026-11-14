# Rules for the AI Co-Pilot

Claude drafts and cross-checks the SQL in this repo; I make the decisions. Read this file before writing any query. Each rule below comes from a data trap found while profiling the database on 2026-11-10.

## How We Work

1. Before writing SQL, restate the business question and the decision it informs. If either is unclear, ask.
2. Every query names its time period in a comment. If a table has no dates, say so.
3. When a query involves a choice with a real alternative, stop and propose an entry for [`docs/design-decisions.md`](docs/design-decisions.md) instead of choosing silently.
4. When I ask for help with a decision, give the strongest argument **against** my current pick before agreeing.
5. Never append to [`PRD.md`](PRD.md). Rewrite the affected section, bump the version, and add one line to its Version History.
6. At the end of a session, update [`docs/handover.md`](docs/handover.md).

## Data Rules

| Table | Rule | Why |
|---|---|---|
| `shopify_checkouts` | Count checkouts with `COUNT(DISTINCT name)`, never `COUNT(*)` | 1,579 rows = 1,197 checkouts (D-12) |
| `shopify_checkouts` | Take money fields only from the row that carries them | Only the first line of a multi-line checkout has totals |
| `shopify_orders` | Exclude `sale_id LIKE '%-S'` from product metrics; keep it for order totals | Shipping rows have a blank product title (D-04) |
| `shopify_sales` | Use `net_sales` for revenue | `total_sales` includes tax (D-01) |
| `shopify_sales` | Never claim a period for its figures | No date column (D-06) |
| `meta_campaigns`, `meta_ad_sets` | Filter or group by `result_indicator` before using `results` | `results` counts different things per campaign (D-02) |
| `meta_campaigns`, `meta_ad_sets` | Treat a blank `results` as not recorded, not zero | D-02 |
| `meta_ad_sets` | Don't identify an ad set by name alone | 11 names repeat across 31 rows |
| `referrals` | Weight rates by pageviews; never average them row by row | Tiny samples show 100% rates |
| `referrals` | Group referrers through the channel table, not ad hoc `LIKE` filters | D-08 |
| Any product join | Join through the product table's `product_id`, not raw titles | D-03 |
| Any figure combining tables | State the time assumption beside the number | D-06; see [`rejected.md`](rejected.md) |
| `data/breaking_games.db` | Never write to it. Run anything that changes data against a copy, or create views | Published unchanged so results can be reproduced (D-13) |

## Output Conventions

- One SQL file per project in `sql/`, numbered to match the roadmap.
- Each query opens with a comment block: question, decision it informs, tables used, time period, decisions it depends on.
- Money rounded to 2 decimals; percentages to 1.
